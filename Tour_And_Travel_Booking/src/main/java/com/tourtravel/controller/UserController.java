package com.tourtravel.controller;

import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.tourtravel.model.Booking;
import com.tourtravel.model.TourPackage;
import com.tourtravel.model.Users;
import com.tourtravel.repository.BookingRepository;
import com.tourtravel.repository.TourPackageRepository;
import com.tourtravel.repository.UserRepository;

@Controller
public class UserController {
    
    @Autowired
    private UserRepository ur;
    
    @Autowired
    private TourPackageRepository tourPackageRepository;
    
    @Autowired
    private BookingRepository bookingRepository;
    
    @PostMapping("/userregister")
    public String userregister(@ModelAttribute Users user) {
        ur.save(user);
        return "UserLogin";
    }

    @GetMapping("/ulogin")
    public String showlogin() {
        return "UserLogin";
    }

    @RequestMapping("/uregister")
    public String showregister() {
        return "UserRegister";
    }

    @GetMapping("/userlogin")
    public String userlogin(@RequestParam String email, 
                            @RequestParam String password,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Users uob = ur.findByEmail(email);
        if (uob != null && email.equals(uob.getEmail()) && password.equals(uob.getPassword())) {
            session.setAttribute("user", uob);
            return "redirect:/userdashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid credentials");
            return "redirect:/ulogin";
        }
    }

    @GetMapping("/userdashboard")
    public String userDashboard(Model model, HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            return "redirect:/ulogin";
        }
        model.addAttribute("tourpackages", tourPackageRepository.findAll());
        model.addAttribute("bookings", bookingRepository.findByUser(user));
        return "UserDashboard";
    }

    @PostMapping("/userbookPackage")
    public String bookPackage(
            @RequestParam("packageId") Integer packageId,
            @RequestParam("numberOfPeople") Integer numberOfPeople,
            @RequestParam("stripeToken") String stripeToken,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            Users user = (Users) session.getAttribute("user");
            if (user == null) {
                return "redirect:/ulogin";
            }
            
            if (packageId == null || numberOfPeople == null || numberOfPeople <= 0) {
                redirectAttributes.addFlashAttribute("error", "Invalid booking parameters");
                return "redirect:/userdashboard";
            }
            
            TourPackage tourPackage = tourPackageRepository.findById(packageId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid tour package"));
            
            if (numberOfPeople > tourPackage.getMaxPeople()) {
                redirectAttributes.addFlashAttribute("error", 
                    "Maximum " + tourPackage.getMaxPeople() + " travelers allowed");
                return "redirect:/book?packageId=" + packageId;
            }
            
            // Create and save booking
            Booking booking = new Booking();
            booking.setUser(user);
            booking.setTourPackage(tourPackage);
            booking.setNumberOfPeople(numberOfPeople);
            booking.setTotalPrice(tourPackage.getPrice() * numberOfPeople);
            booking.setBookingDate(LocalDateTime.now());
            booking.setStatus(Booking.BookingStatus.PENDING_PAYMENT);
            booking.setPaymentMethod(Booking.PaymentMethod.CREDIT_CARD); // Set from form input in real implementation
            booking.setTransactionId(stripeToken);
            
            bookingRepository.save(booking);
            
            redirectAttributes.addFlashAttribute("success", "Booking created successfully!");
            return "redirect:/userdashboard";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Booking failed: " + e.getMessage());
            return "redirect:/book?packageId=" + packageId;
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/Home";
    }
    
    @GetMapping("/mybookings")
    public String showMyBookings(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("user");
        if (user == null) return "redirect:/ulogin";
        
        List<Booking> bookings = bookingRepository.findByUser(user);
        model.addAttribute("bookings", bookings);
        
        return "MyBookings";
    }
}