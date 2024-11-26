<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background */
            display: flex; /* Use flexbox for centering */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            height: 100vh; 
            margin: 0;
        }
        .container {
            background-color: white; /* White background for the message */
            padding: 30px; /* Padding around the message */
            border-radius: 15px; /* Rounded corners */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
            text-align: center; /* Center text */
            max-width: 400px; /* Maximum width for responsiveness */
        }
        h1 {
            color: #ff6f61; /* Vibrant color for the heading */
            margin-bottom: 10px; /* Space below the heading */
            font-size: 24px; /* Heading font size */
        }
        p {
            color: #555; /* Medium gray color for the text */
            font-size: 16px; /* Text font size */
            line-height: 1.5; /* Line height for better readability */
        }
        .button {
            display: inline-block; /* Block element for button */
            background-color: #4CAF50; /* Green background */
            color: white; /* White text */
            padding: 10px 20px; /* Padding for the button */
            margin-top: 20px; /* Space above the button */
            border-radius: 5px; /* Rounded corners */
            text-decoration: none; /* Remove underline from link */
            font-weight: bold; /* Bold text */
            transition: background-color 0.3s ease; /* Smooth transition */
        }
        .button:hover {
            background-color: #45a049; /* Darker green on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Order Was Placed!</h1>
        <p>Thank you for your purchase.</p>
        <a class="button" href="home.jsp">Back to Home</a>
    </div>
</body>
</html>
