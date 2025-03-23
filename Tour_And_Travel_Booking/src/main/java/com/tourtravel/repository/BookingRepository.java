package com.tourtravel.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tourtravel.model.Booking;
import com.tourtravel.model.Users;

public interface BookingRepository extends JpaRepository<Booking, Integer> 
{
	//public abstract Booking findByUser(Users user);
	List<Booking> findByUser(Users user);
	
	
	public abstract Booking findByTransactionId(String transactionId);
	
}