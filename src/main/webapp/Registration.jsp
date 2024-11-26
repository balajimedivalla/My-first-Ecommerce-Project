<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        header {
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 05px 0;
            text-align: center;
        }

        .login-link {
            float: right;
            margin-right: 30px;
        }

        .login-link a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        main {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: auto;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"],
        select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 16px;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        input[type="submit"] {
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green */
        }

        @media (max-width: 600px) {
            main {
                padding: 15px;
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="login-link">
            <a href="login.jsp">Sign In</a>
        </div>
        <h1>Registration Form</h1>
    </header>
    <main>
        <form action="RegistrationServlet" method="post">
            <label for="FirstName">First Name:</label>
            <input type="text" id="FirstName" name="FirstName" required>

            <label for="LastName">Last Name:</label>
            <input type="text" id="LastName" name="LastName" required>

            <label for="Email">Email:</label>
            <input type="email" id="Email" name="Email" required>

            <label for="Password">Password:</label>
            <input type="password" id="Password" name="Password" required>

            <label for="UserRole">User Role:</label>
            <select id="UserRole" name="UserRole" required>
                <option value="" disabled selected>Select your role</option>
                <option value="buyer">Buyer</option>
                <option value="seller">Seller</option>
            </select>

            <label>Gender:</label>
            <div>
                <input type="radio" id="male" name="Gender" value="male" required>
                <label for="male">Male</label>
            </div>
            <div>
                <input type="radio" id="female" name="Gender" value="female" required>
                <label for="female">Female</label>
            </div>
            <div>
                <input type="radio" id="other" name="Gender" value="other" required>
                <label for="other">Other</label>
            </div>

            <label for="MobileNumber">Mobile Number:</label>
            <input type="tel" id="MobileNumber" name="MobileNumber" required pattern="[0-9]{10}" title="Please enter a 10-digit mobile number.">

            <input type="submit" value="Register">
        </form>
    </main>
</body>
</html>
