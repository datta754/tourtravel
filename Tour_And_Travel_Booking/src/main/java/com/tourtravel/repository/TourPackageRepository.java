package com.tourtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tourtravel.model.TourPackage;

@Repository
public interface TourPackageRepository extends JpaRepository<TourPackage, Integer>
{

}
