package com.tourtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.tourtravel.model.TourPackage;
import com.tourtravel.repository.TourPackageRepository;

@Controller
public class BookingController {

    @Autowired
    private TourPackageRepository tourPackageRepository;

    

    @GetMapping("/book")
    public String showBookingForm(@RequestParam("packageId") int packageId, Model model,
                                 @ModelAttribute("error") String error) {
        TourPackage tourPackage = tourPackageRepository.findById(packageId).orElse(null);
        System.out.println(tourPackage);    
        model.addAttribute("tourpackage1", tourPackage);
        
        
        if (error != null) {
            model.addAttribute("error", error);
        }
        return "BookPackage";
    }
    

    
}