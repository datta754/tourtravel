package com.tourtravel.controller;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tourtravel.model.TourPackage;
import com.tourtravel.repository.BookingRepository;
import com.tourtravel.repository.TourPackageRepository;
import com.tourtravel.repository.UserRepository;

@Controller
public class TourPackageController {

    @Autowired
    private TourPackageRepository tpr;
    
    @Autowired
    UserRepository ur;
    
    @Autowired
    BookingRepository bookingRepository;
    
    
    public static String UPLOAD_DIRECTORY = System.getProperty("user.dir") + "/uploads";

    @GetMapping("/admindashboard")
    public String adminDashboard(Model model) {
        model.addAttribute("tourpackages", tpr.findAll());
        model.addAttribute("users", ur.findAll());
        model.addAttribute("allBookings", bookingRepository.findAll());
        return "AdminDashboard";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                setValue(LocalDate.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }
        });
    }

    @GetMapping("/apackage")
    public String showAddPackage(Model model) {
        model.addAttribute("tourPackage", new TourPackage());
        return "add-package";
    }

    @PostMapping("/addpackages")
    public String addPackage(
            @ModelAttribute("tourPackage") @Valid TourPackage tp,
            BindingResult result,
            @RequestParam("imageFile") MultipartFile file) throws IOException {  // Added imageFile parameter

        if (result.hasErrors()) {
            return "add-package";
        }

        // Handle image upload
        if (!file.isEmpty()) {
            // Create upload directory if not exists
            Path uploadPath = Paths.get(UPLOAD_DIRECTORY);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Save file to uploads directory
            Path filePath = uploadPath.resolve(file.getOriginalFilename());
            Files.write(filePath, file.getBytes());

            // Set image filename in entity
            tp.setImageFileName(file.getOriginalFilename());
        }

        tpr.save(tp);
        return "redirect:/admindashboard";
    }
    
    
    @GetMapping("/deletePackage")
    public String deletePackage(@RequestParam("id") int packageId, RedirectAttributes redirectAttrs) {
        try {
            tpr.deleteById(packageId);
            redirectAttrs.addFlashAttribute("successMessage", "Package deleted successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Cannot delete package. It may have existing bookings.");
        }
        return "redirect:/admindashboard";
    }

    
}