<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TravelBuddy - Admin Portal</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                        url('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .admin-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            border-top: 4px solid #dc3545;
        }

        .admin-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .admin-header h2 {
            color: #dc3545;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .admin-header p {
            color: #666;
            font-size: 0.9em;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #dc3545;
        }

        .admin-btn {
            width: 100%;
            padding: 12px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .admin-btn:hover {
            background-color: #c82333;
        }

        .security-note {
            text-align: center;
            margin-top: 25px;
            font-size: 0.8em;
            color: #666;
        }

        .return-home {
            text-align: center;
            margin-top: 25px;
        }

        .return-home a {
            color: white;
            text-decoration: none;
            font-size: 0.9em;
            display: inline-block;
            margin-top: 20px;
            padding: 8px 15px;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.1);
            transition: background-color 0.3s;
        }

        .return-home a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        @media (max-width: 480px) {
            .admin-container {
                margin: 20px;
                padding: 25px;
            }
            
            .admin-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>

	<body>
    <div class="admin-container">
        <div class="admin-header">
            <h2>Admin Portal</h2>
            <p>Restricted access to authorized personnel only</p>
        </div>

        <form action="adminlogin" method="get">
            <div class="form-group">
                <label for="adminUsername">Username</label>
                <input type="text" 
                       id="adminUsername" 
                       name="username" 
                       required
                       autocomplete="off"
                       autocapitalize="none">
            </div>

            <div class="form-group">
                <label for="adminPassword">Password</label>
                <input type="password" 
                       id="adminPassword" 
                       name="password" 
                       required
                       autocomplete="off"
                       minlength="8">
            </div>

            <button type="submit" class="admin-btn">Secure Login</button>
        </form>

        <div class="security-note">
            <i class="fas fa-shield-alt"></i> All activities are monitored and logged
        </div>
    </div>

    <div class="return-home">
        <a href="Home.jsp">← Return to Public Site</a>
    </div>

    <script>
        const form = document.getElementById('adminLoginForm');
        
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Add admin login validation logic here
            const username = document.getElementById('adminUsername').value;
            const password = document.getElementById('adminPassword').value;
            
            // Example validation (replace with actual authentication)
            if(username === 'admin' && password === 'securePassword123') {
                alert('Admin login successful!');
                // Redirect to admin dashboard
                window.location.href = 'admin-dashboard.html';
            } else {
                alert('Invalid admin credentials!');
            }
        });
    </script>
</body>

</html>