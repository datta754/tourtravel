<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explore Tours - User Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    :root {
        --primary-color: #003366;
        --secondary-color: #ff6600;
        --background: #f0f8ff;
        --text-color: #333;
        --shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        background: var(--background);
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100vw;
        height: 100vh;
        overflow-x: hidden;
    }

    .navbar {
        width: 100%;
        background: var(--primary-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 50px;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        box-shadow: var(--shadow);
    }

    .navbar a {
        color: white;
        text-decoration: none;
        font-size: 1.2rem;
        padding: 10px 20px;
        border-radius: 8px;
        transition: background 0.3s ease;
    }

    .navbar a:hover {
        background: rgba(255, 255, 255, 0.3);
    }

    .main-content {
        width: 90%;
        max-width: 1400px;
        margin-top: 90px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .container {
        width: 100%;
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: var(--shadow);
        transition: transform 0.3s ease;
    }

    .container:hover {
        transform: scale(1.02);
    }

    .header {
        text-align: center;
        margin-bottom: 20px;
    }

    .header h1 {
        color: var(--primary-color);
        font-size: 2.5rem;
    }

    .header p {
        color: var(--text-color);
        font-size: 1.2rem;
    }

    .package-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        margin-top: 20px;
    }

    .package-card {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: var(--shadow);
        transition: transform 0.3s ease;
    }

    .package-card:hover {
        transform: translateY(-8px);
    }

    .card-image {
        width: 100%;
        height: 220px;
        object-fit: cover;
    }

    .card-content {
        padding: 20px;
    }

    .package-title {
        color: var(--primary-color);
        font-size: 1.5rem;
        font-weight: bold;
    }

    .destination {
        color: #555;
        font-size: 1rem;
        margin: 10px 0;
    }

    .details {
        display: flex;
        justify-content: space-between;
        font-size: 1rem;
        color: #444;
        margin-bottom: 10px;
    }

    .price {
        font-size: 1.4rem;
        color: var(--secondary-color);
        font-weight: bold;
    }

    .book-btn {
        background: var(--primary-color);
        color: white;
        border: none;
        padding: 12px;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s ease;
        width: 100%;
        font-size: 1rem;
        font-weight: bold;
    }

    .book-btn:hover {
        background: var(--secondary-color);
    }

    .booking-section {
        margin-top: 40px;
    }

    .booking-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: white;
        box-shadow: var(--shadow);
        border-radius: 10px;
        overflow: hidden;
    }

    .booking-table th, .booking-table td {
        padding: 14px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .booking-table th {
        background-color: var(--primary-color);
        color: white;
    }
</style>
</head>
<body>
<nav class="navbar">
    <a href="/">Home</a>
    <a href="#bookings">My Bookings</a>
    <a href="#packages">Packages</a>
    <a href="/">Logout</a>
</nav>
<div class="main-content">
    <div class="container" id="packages">
        <div class="header">
            <h1>Discover Your Next Adventure</h1>
            <p>Explore our curated collection of amazing tour packages</p>
        </div>
        <div class="package-grid">
            <c:forEach items="${tourpackages}" var="pkg">
                <div class="package-card">
                    <img src="/uploads/${pkg.imageFileName}" alt="${pkg.packageName}" class="card-image">
                    <div class="card-content">
                        <h3 class="package-title">${pkg.packageName}</h3>
                        <div class="destination"><i class="fas fa-map-marker-alt"></i> ${pkg.destination}</div>
                        <div class="details">
                            <span><i class="fas fa-calendar-alt"></i> ${pkg.durationDays} Days</span>
                            <span><i class="fas fa-user-friends"></i> Max ${pkg.maxPeople}</span>
                        </div>
                        <div class="price">$${pkg.price} per person</div>
                        <button class="book-btn" onclick="window.location.href='/book?packageId=${pkg.packageId}'">
                            <i class="fas fa-shopping-cart"></i> Book Now
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="container booking-section" id="bookings">
        <h2>My Bookings</h2>
        <table class="booking-table">
            <tr>
                <th>Package</th>
                <th>Date</th>
                <th>Travelers</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
            <c:forEach items="${bookings}" var="booking">
                <tr>
                    <td>${booking.tourPackage.packageName}</td>
                    <td>${booking.bookingDate}</td>
                    <td>${booking.numberOfPeople}</td>
                    <td>$${booking.totalPrice}</td>
                    <td>${booking.status}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
