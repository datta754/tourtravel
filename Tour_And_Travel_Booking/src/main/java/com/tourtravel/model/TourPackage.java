package com.tourtravel.model;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class TourPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int packageId;

    private String packageName;
    private String destination;
    private int durationDays;
    private int durationNights;
    private double price;
    private int maxPeople;
    private String description;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;

    @Column(columnDefinition = "TEXT")
    private String inclusions;

    private String exclusions;
    private String imageFileName;

    public TourPackage() {
        super();
    }

    public TourPackage(int packageId, String packageName, String destination, int durationDays, int durationNights,
                       double price, int maxPeople, String description, LocalDate startDate, LocalDate endDate,
                       List<String> inclusions, String exclusions, String imageFileName) {
        super();
        this.packageId = packageId;
        this.packageName = packageName;
        this.destination = destination;
        this.durationDays = durationDays;
        this.durationNights = durationNights;
        this.price = price;
        this.maxPeople = maxPeople;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.setInclusionsList(inclusions);
        this.exclusions = exclusions;
        this.imageFileName = imageFileName;
    }

    // Getters and Setters
    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public int getDurationNights() {
        return durationNights;
    }

    public void setDurationNights(int durationNights) {
        this.durationNights = durationNights;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(int maxPeople) {
        this.maxPeople = maxPeople;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getInclusions() {
        return inclusions;
    }

    public void setInclusions(String inclusions) {
        this.inclusions = inclusions;
    }

    public List<String> getInclusionsList() {
        return inclusions != null ? Arrays.asList(inclusions.split(",")) : null;
    }

    public void setInclusionsList(List<String> inclusions) {
        this.inclusions = String.join(",", inclusions);
    }

    public String getExclusions() {
        return exclusions;
    }

    public void setExclusions(String exclusions) {
        this.exclusions = exclusions;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }
}
