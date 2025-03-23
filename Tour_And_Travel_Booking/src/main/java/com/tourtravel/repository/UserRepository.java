package com.tourtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tourtravel.model.Users;

public interface UserRepository extends JpaRepository<Users, Integer>
{
	public abstract Users findByEmail(String email);
}
