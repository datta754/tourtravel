<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <style>
        .booking-card {
            background: white;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>My Bookings</h1>
        
        <c:forEach items="${bookings}" var="booking">
            <div class="booking-card">
                <h3>${booking.tourPackage.packageName}</h3>
                <p>Destination: ${booking.tourPackage.destination}</p>
                <p>Booking Date: ${booking.bookingDate}</p>
                <p>Travelers: ${booking.numberOfPeople}</p>
                <p>Total Price: $${booking.totalPrice}</p>
                <p>Status: ${booking.status}</p>
            </div>
        </c:forEach>
    </div>
</body>
</html>