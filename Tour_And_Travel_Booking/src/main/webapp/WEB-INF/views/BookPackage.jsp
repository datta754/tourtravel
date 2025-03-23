<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Package</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #ffffff;
            text-align: center;
            padding: 20px;
        }
        .booking-container {
            max-width: 600px;
            margin: auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        h2, h3 {
            color: #ffcc00;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }
        .payment-methods {
            display: flex;
            justify-content: space-around;
            margin: 15px 0;
        }
        .payment-option {
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            background: rgba(255, 255, 255, 0.1);
            transition: 0.3s;
        }
        .payment-option:hover, .payment-option.selected {
            background: rgba(255, 255, 255, 0.3);
        }
        button {
            padding: 10px 20px;
            border: none;
            background: #ffcc00;
            color: #1e3c72;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        #card-element {
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>
        
        <c:if test="${not empty tourpackage1}">
            <h2>${tourpackage1.packageName}</h2>
            <p>Destination: ${tourpackage1.destination}</p>
            <p>Price per person: $${tourpackage1.price}</p>
            <p>Max People: ${tourpackage1.maxPeople}</p>

            <form id="bookingForm" action="${pageContext.request.contextPath}/userbookPackage" method="post">
                <input type="hidden" name="packageId" value="${tourpackage1.packageId}">
                
                <div class="form-group">
                    <label>Number of Travelers</label>
                    <input type="number" id="numberOfPeople" name="numberOfPeople" required min="1" max="${tourpackage1.maxPeople}">
                </div>

                <div class="payment-methods">
                    <div class="payment-option" id="creditCardOption">
                        <input type="radio" name="paymentMethod" value="CREDIT_CARD" required>
                        <label><i class="fab fa-cc-visa"></i> Credit/Debit Card</label>
                    </div>
                    <div class="payment-option" id="paypalOption">
                        <input type="radio" name="paymentMethod" value="PAYPAL">
                        <label><i class="fab fa-cc-paypal"></i> PayPal</label>
                    </div>
                </div>
                
                <div id="card-element"></div>
                <div id="card-errors" class="error-message"></div>
                
                <input type="hidden" id="stripeToken" name="stripeToken">
                <button type="submit">Confirm Booking</button>
            </form>
        </c:if>
    </div>

    <script src="https://js.stripe.com/v3/"></script>
    <script>
        const stripe = Stripe('${stripePublicKey}');
        const elements = stripe.elements();
        const cardElement = elements.create('card', {
            style: { base: { color: '#ffffff', fontFamily: 'Poppins, sans-serif' } }
        });
        cardElement.mount('#card-element');
        document.getElementById('bookingForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            if (paymentMethod === 'CREDIT_CARD') {
                const { token, error } = await stripe.createToken(cardElement);
                if (error) {
                    document.getElementById('card-errors').textContent = error.message;
                    return;
                }
                document.getElementById('stripeToken').value = token.id;
            }
            e.target.submit();
        });
    </script>
</body>
</html>