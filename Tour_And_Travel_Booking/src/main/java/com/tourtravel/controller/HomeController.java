package com.tourtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tourtravel.model.Booking;
import com.tourtravel.repository.BookingRepository;
import com.tourtravel.repository.ResourceNotFoundException;

@Controller
public class HomeController {
	
	@Autowired
	BookingRepository bookingRepository;
	
	
    @RequestMapping("/")
    public String homepage() {
        return "Home";
    }
    
    @RequestMapping("/alogin")
    public String adminlogin() {
        return "AdminLogin";
    }
    
    @GetMapping("/adminlogin")
    public String adminlogindash(@RequestParam String username, 
                               @RequestParam String password) {
        if(username.equals("admin") && password.equals("admin123")) {
            return "redirect:/admindashboard";
        } else {
            return "AdminLogin";
        }
    }
    
    
    @PostMapping("/updateStatus")
    public String updateBookingStatus(@RequestParam("bookingId") int bookingId,
                                     @RequestParam("status") Booking.BookingStatus status,
                                     RedirectAttributes redirectAttributes) {
        try {
            Booking booking = bookingRepository.findById(bookingId)
                    .orElseThrow(() -> new ResourceNotFoundException("Booking not found"));
            
            booking.setStatus(status);
            bookingRepository.save(booking);
            
            redirectAttributes.addFlashAttribute("success", "Status updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating status: " + e.getMessage());
        }
        return "redirect:/admindashboard";
    }
    
}