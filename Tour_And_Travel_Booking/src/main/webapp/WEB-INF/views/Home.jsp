<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TravelBuddy - Explore the World</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Arial', sans-serif;
    }

    /* Navbar */
    nav {
        background-color: #003b95;
        padding: 15px 50px;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        color: white;
        font-size: 24px;
        font-weight: bold;
    }

    .nav-links {
        display: flex;
        gap: 30px;
    }

    .nav-links li {
        list-style: none;
    }

    .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 16px;
        transition: color 0.3s;
    }

    .nav-links a:hover {
        color: #ffb700;
    }

    /* Hero Section */
    .hero {
        height: 100vh;
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                    url('https://images.unsplash.com/photo-1503220317375-aaad61436b1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
        background-size: cover;
        background-position: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        color: white;
        padding: 0 20px;
    }

    .hero-content h1 {
        font-size: 48px;
        margin-bottom: 20px;
    }

    .hero-content p {
        font-size: 24px;
        margin-bottom: 30px;
    }

    /* Search Bar */
    .search-container {
        margin-top: 20px;
    }

    .search-input {
        padding: 12px;
        width: 250px;
        border: none;
        border-radius: 25px;
        font-size: 16px;
        text-align: center;
    }

    .search-btn {
        padding: 12px 20px;
        background-color: #ff6b00;
        color: white;
        border: none;
        border-radius: 25px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .search-btn:hover {
        background-color: #ff5500;
    }

    /* Featured Destinations */
    .destinations {
        text-align: center;
        margin: 50px 0;
    }

    .destinations h2 {
        color: #003b95;
        margin-bottom: 15px;
    }

    .grid {
        display: flex;
        justify-content: center;
        gap: 20px;
        flex-wrap: wrap;
    }

    .card {
        background: white;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 250px;
    }

    .card img {
        width: 100%;
        border-radius: 10px;
    }

    .card h3 {
        margin-top: 10px;
        color: #003b95;
    }

    /* Testimonials */
    .testimonials {
        background: #f4f4f9;
        padding: 50px;
        text-align: center;
    }

    .testimonials h2 {
        color: #003b95;
        margin-bottom: 20px;
    }

    .testimonial {
        background: white;
        padding: 20px;
        margin: 10px auto;
        width: 50%;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    .testimonial p {
        font-size: 18px;
        font-style: italic;
    }

    .testimonial h4 {
        margin-top: 10px;
        color: #ff6b00;
    }

    /* Special Offers */
    .offers {
        background: #ffb700;
        padding: 30px;
        text-align: center;
        color: white;
    }

    .offers p {
        font-size: 18px;
        margin-bottom: 10px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        nav {
            padding: 15px 20px;
        }
        
        .nav-links {
            gap: 15px;
        }
        
        .hero-content h1 {
            font-size: 36px;
        }
        
        .hero-content p {
            font-size: 18px;
        }

        .testimonial {
            width: 80%;
        }
    }
</style>
</head>
<body>

    <nav>
        <div class="logo">TravelBuddy</div>
        <ul class="nav-links">
            <li><a href="ulogin">User Register/Login</a></li>
            <li><a href="alogin">Admin Login</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <div class="hero">
        <div class="hero-content">
            <h1>Discover Your Next Adventure</h1>
            <p>Book unforgettable tours and experiences worldwide</p>
            
            <div class="search-container">
    <input type="text" class="search-input" placeholder="Search for destinations...">
    <button class="search-btn" onclick="redirectToLogin()">Search</button>
</div>
        </div>
    </div>

    <!-- Featured Destinations -->
    <div class="destinations">
        <h2>Popular Destinations</h2>
        <div class="grid">
            <div class="card">
                <img src="https://source.unsplash.com/300x200/?paris,travel" alt="Paris">
                <h3>Paris</h3>
                <p>Experience the city of love!</p>
            </div>
            <div class="card">
                <img src="https://source.unsplash.com/300x200/?maldives,beach" alt="Maldives">
                <h3>Maldives</h3>
                <p>Relax on the best beaches!</p>
            </div>
            <div class="card">
                <img src="https://source.unsplash.com/300x200/?bali,travel" alt="Bali">
                <h3>Bali</h3>
                <p>A tropical paradise awaits!</p>
            </div>
        </div>
    </div>

    <!-- Testimonials -->
    <div class="testimonials">
        <h2>What Our Travelers Say</h2>
        <div class="testimonial">
            <p>"TravelBuddy made my dream trip a reality! Highly recommended!"</p>
            <h4>- Akash Shere</h4>
        </div>
        <div class="testimonial">
            <p>"Best experience ever! The booking process was seamless and easy."</p>
            <h4>- Abhi Yadav.</h4>
        </div>
    </div>

    <div class="offers">
    <h2>Limited-Time Offers</h2>
    <p>Save up to 30% on selected destinations. Book now!</p>
    <button class="search-btn" onclick="redirectToLogin()">Explore Deals</button>
</div>
<script>
    function redirectToLogin() {
        window.location.href = "ulogin";
    }
</script>

</body>
</html>
