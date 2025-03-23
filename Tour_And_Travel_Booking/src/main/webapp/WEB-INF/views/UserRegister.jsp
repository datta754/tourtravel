<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TravelBuddy - Register</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('https://images.unsplash.com/photo-1503220317375-aaad61436b1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
        }

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-header h2 {
            color: #003b95;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .register-header p {
            color: #666;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
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
            border-color: #003b95;
        }

        .password-match-error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .register-btn {
            width: 100%;
            padding: 12px;
            background-color: #ff6b00;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .register-btn:hover {
            background-color: #ff5500;
        }

        .additional-links {
            margin-top: 20px;
            text-align: center;
        }

        .additional-links a {
            color: #003b95;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .additional-links a:hover {
            color: #ff6b00;
        }

        .return-home {
            text-align: center;
            margin-top: 20px;
        }

        .return-home a {
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        @media (max-width: 480px) {
            .register-container {
                margin: 20px;
                padding: 25px;
            }
            
            .register-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>Create Account</h2>
            <p>Start planning your next adventure</p>
        </div>

        <form action="userregister" method="post">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" required autocomplete="name">
            </div>

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autocomplete="username">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required autocomplete="new-password">
            </div>

            <div class="form-group">
                <label for="confirmpassword">Confirm Password</label>
                <input type="password" id="confirmpassword" name="confirmpassword" required autocomplete="new-password">
                <div class="password-match-error" id="passwordError">
                    Passwords do not match!
                </div>
            </div>

            <button type="submit" class="register-btn">Create Account</button>

            <div class="additional-links">
                <a href="ulogin">Already have an account? Login</a>
            </div>
        </form>
    </div>

    <div class="return-home">
        <a href="index.html">← Return to Home</a>
    </div>

    <script>
        const form = document.getElementById('registrationForm');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmpassword');
        const passwordError = document.getElementById('passwordError');

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            if(passwordInput.value !== confirmPasswordInput.value) {
                passwordError.style.display = 'block';
                confirmPasswordInput.focus();
            } else {
                passwordError.style.display = 'none';
                // Here you would typically handle form submission
                alert('Registration successful!');
                form.reset();
            }
        });
    </script>
</body>
</html>