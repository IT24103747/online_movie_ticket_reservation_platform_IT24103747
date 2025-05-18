<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="login/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>
<div class="auth-container">
    <!-- Logo Section -->
    <div class="logo-container" style="text-align: center; margin-bottom: 20px;">
        <!-- You can add your logo here -->
    </div>

    <div class="login-container" id="loginContainer">
        <h1>Login</h1>

        <!-- Display error message if any -->
        <div id="errorMessage" class="error-message" style="display: none; color: red; margin-bottom: 15px;"></div>

        <form id="loginForm" action="signing" method="POST" onsubmit="return validateForm()">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="options">
                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember">Remember Me</label>
                </div>
                <a href="forgotPassword.jsp" class="forgot-password">Forgot Password</a>
            </div>

            <button type="submit" class="auth-button">Login</button>
        </form>

        <div class="switch-auth">
            Don't have an account? <a href="signup.jsp" class="switch-link">Sign Up</a>
        </div>
    </div>
</div>

<script>
    function validateForm() {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        const errorElement = document.getElementById('errorMessage');

        // Basic validation
        if (username === '' || password === '') {
            errorElement.textContent = 'Please fill in all fields';
            errorElement.style.display = 'block';
            return false;
        }

        // You can add more validation here if needed
        // For example, password length requirements

        return true; // Form will submit if validation passes
    }

    // Clear error message when user starts typing
    document.getElementById('username').addEventListener('input', function() {
        document.getElementById('errorMessage').style.display = 'none';
    });

    document.getElementById('password').addEventListener('input', function() {
        document.getElementById('errorMessage').style.display = 'none';
    });
</script>
</body>
</html>