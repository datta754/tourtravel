<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
    body { 
        font-family: Arial, sans-serif; 
        margin: 0; 
        background: #f4f4f9;
    }
    .navbar {
        background: #003b95; 
        padding: 15px 20px; 
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        color: white;
    }
    .navbar h1 { margin: 0; font-size: 24px; }
    .navbar a {
        color: white; 
        text-decoration: none; 
        margin-left: 20px; 
        font-size: 16px;
        padding: 8px 15px;
        border-radius: 5px;
    }
    .navbar a:hover { background: rgba(255,255,255,0.2); }
    
    .container {
        width: 90%;
        margin: auto;
        padding: 20px;
    }

    h2 { 
        color: #003b95; 
        margin-bottom: 15px;
    }

    .section-container {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    table { 
        width: 100%; 
        border-collapse: collapse; 
        margin-top: 15px; 
    }
    
    th, td { 
        padding: 12px; 
        text-align: left; 
        border-bottom: 1px solid #ddd; 
    }
    
    th {
        background-color: #003b95; 
        color: white;
    }

    tr:hover { background: #f1f1f1; }

    .actions a {
        color: #003b95;
        text-decoration: none;
        font-weight: bold;
        margin-right: 10px;
        padding: 5px 10px;
        border-radius: 4px;
        transition: 0.3s;
    }
    
    .actions a:hover { background: #003b95; color: white; }

    .add-btn { 
        background: #28a745; 
        color: white; 
        padding: 10px 15px; 
        text-decoration: none; 
        border-radius: 4px;
        font-weight: bold;
    }

    .add-btn:hover { background: #218838; }
</style>
</head>
<body>
<c:if test="${not empty successMessage}">
    <div style="background: #28a745; color: white; padding: 10px; margin-bottom: 20px; border-radius: 5px;">
        ${successMessage}
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div style="background: #dc3545; color: white; padding: 10px; margin-bottom: 20px; border-radius: 5px;">
        ${errorMessage}
    </div>
</c:if>

<div class="navbar">
    <h1>Admin Dashboard</h1>
    <div>
        <a href="${pageContext.request.contextPath}/apackage">Add Package</a>
        <a href="${pageContext.request.contextPath}/" style="background: #dc3545;">Home</a>
    </div>
</div>

<div class="container">

    <div class="section-container">
        <h2>Tour Packages</h2>
        <table>
            <tr>
                <th>Package Name</th>
                <th>Destination</th>
                <th>Duration</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            <c:forEach items="${tourpackages}" var="pkg">
                <tr>
                    <td>${pkg.packageName}</td>
                    <td>${pkg.destination}</td>
                    <td>${pkg.durationDays} Days / ${pkg.durationNights} Nights</td>
                    <td>$${pkg.price}</td>
                    <td class="actions">
                        
<a href="deletePackage?id=${pkg.packageId}" 
   style="color: red;" 
   onclick="return confirm('Are you sure you want to delete this package?');">
   Delete
</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="section-container">
        <h2>Registered Users</h2>
        <table>
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Email</th>
               
            </tr>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.fullname}</td>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    
                </tr>
            </c:forEach>
        </table>
    </div>
    
    <div class="section-container">
        <h2>All Bookings</h2>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>User</th>
                <th>Package</th>
                <th>Date</th>
                <th>People</th>
                <th>Total</th>
                <th>Payment Method</th>
    			<th>Transaction ID</th>
   				 <th>Amount Paid</th>
  				  <th>Payment Date</th>
   				 <th>Status</th>
            </tr>
            <c:forEach items="${allBookings}" var="booking">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>${booking.user.fullname}</td>
                    <td>${booking.tourPackage.packageName}</td>
                    <td>${booking.bookingDate}</td>
                    <td>${booking.numberOfPeople}</td>
                    <td>$${booking.totalPrice}</td>
                    <td>${booking.paymentMethod}</td>
        <td>${booking.transactionId}</td>
        <td>$${booking.amountPaid}</td>
        <td>${booking.paymentDate}</td>
        <td>
            <form action="/updateStatus" method="post">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                <select name="status" onchange="this.form.submit()">
                    <c:forEach items="${booking.status.values()}" var="statusOption">
                        <option value="${statusOption}" 
                            ${booking.status == statusOption ? 'selected' : ''}>
                            ${statusOption}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </td>
                </tr>
            </c:forEach>
        </table>
    </div>

</div>

</body>
</html>
