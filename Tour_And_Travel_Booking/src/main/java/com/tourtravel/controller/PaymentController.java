package com.tourtravel.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.model.Refund;
import com.tourtravel.model.Booking;
import com.tourtravel.repository.BookingRepository;
import com.tourtravel.repository.ResourceNotFoundException;

@Controller
public class PaymentController {

    private final BookingRepository bookingRepository;

    @Value("${stripe.secret.key}")
    private String stripeSecretKey;

    @Autowired
    public PaymentController(BookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }

    @PostConstruct
    public void init() {
        Stripe.apiKey = stripeSecretKey;
    }

    @PostMapping("/processPayment")
    public String processPayment(
            @RequestParam("bookingId") int bookingId,
            @RequestParam("paymentMethod") Booking.PaymentMethod paymentMethod,
            @RequestParam("stripeToken") String stripeToken,
            RedirectAttributes redirectAttributes) {

        try {
            Booking booking = bookingRepository.findById(bookingId)
                    .orElseThrow(() -> new ResourceNotFoundException("Booking not found with id: " + bookingId));

            Charge charge = processStripePayment(booking.getTotalPrice(), stripeToken);
            
            updateBookingAfterPayment(booking, paymentMethod, charge);
            
            redirectAttributes.addFlashAttribute("success", 
                "Payment successful! Transaction ID: " + charge.getId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Payment failed: " + e.getMessage());
            return "redirect:/book?packageId=" + bookingId;
        }
        
        return "redirect:/userdashboard";
    }

    private Charge processStripePayment(double amount, String token) throws StripeException {
        Map<String, Object> chargeParams = new HashMap<>();
        chargeParams.put("amount", (int) (amount * 100));
        chargeParams.put("currency", "usd");
        chargeParams.put("source", token);
        chargeParams.put("description", "Travel Package Payment");
        
        return Charge.create(chargeParams);
    }

    private void updateBookingAfterPayment(Booking booking, 
                                          Booking.PaymentMethod paymentMethod,
                                          Charge charge) {
        booking.setStatus(Booking.BookingStatus.CONFIRMED);
        booking.setPaymentMethod(paymentMethod);
        booking.setTransactionId(charge.getId());
        booking.setAmountPaid(booking.getTotalPrice());
        booking.setPaymentDate(LocalDateTime.now());
        bookingRepository.save(booking);
    }

    @PostMapping("/processRefund")
    public String processRefund(
            @RequestParam("transactionId") String transactionId,
            RedirectAttributes redirectAttributes) {
        
        try {
            Optional<Booking> bookingOpt = Optional.ofNullable(bookingRepository.findByTransactionId(transactionId));
            if (bookingOpt.isEmpty()) {
                throw new ResourceNotFoundException("Transaction not found: " + transactionId);
            }
            
            Refund refund = processStripeRefund(transactionId);
            updateBookingAfterRefund(bookingOpt.get());
            
            redirectAttributes.addFlashAttribute("success", 
                "Refund processed successfully. Refund ID: " + refund.getId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Refund failed: " + e.getMessage());
        }
        
        return "redirect:/admindashboard";
    }

    private Refund processStripeRefund(String transactionId) throws StripeException {
        Map<String, Object> params = new HashMap<>();
        params.put("charge", transactionId);
        return Refund.create(params);
    }

    private void updateBookingAfterRefund(Booking booking) {
        booking.setStatus(Booking.BookingStatus.REFUNDED);
        bookingRepository.save(booking);
    }
}