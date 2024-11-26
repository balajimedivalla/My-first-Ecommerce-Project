<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #fff; /* White text for better contrast */
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            padding: 30px; /* Increased padding for a spacious look */
            border-radius: 15px; /* More rounded corners */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3); /* Enhanced shadow for depth */
            text-align: center;
            max-width: 500px; /* Maximum width for the container */
            transition: transform 0.3s; /* Smooth transform for hover effect */
        }

        .container:hover {
            transform: scale(1.05); /* Slight scale up on hover */
        }

        h1 {
            color: #ff6f61; /* Coral color for the heading */
            margin-bottom: 15px; /* Space below the heading */
            font-size: 2em; /* Larger font size for the heading */
        }

        p {
            color: #333; /* Dark gray color for the text */
            font-size: 1.1em; /* Slightly larger text for better readability */
        }

        .order-details {
            text-align: left;
            margin-top: 20px;
            border-top: 1px solid #ff6f61; /* Divider with coral color */
            padding-top: 10px; /* Padding above order details */
        }

        strong {
            color: #ff6f61; /* Coral color for strong text */
        }

        /* Button styling */
        .button {
            display: inline-block; /* Inline block for button */
            background-color: #ff6f61; /* Button color */
            color: #fff; /* White text */
            padding: 10px 20px; /* Padding for button */
            border: none; /* No border */
            border-radius: 5px; /* Rounded corners for button */
            text-decoration: none; /* Remove underline */
            font-weight: bold; /* Bold text */
            transition: background-color 0.3s; /* Smooth background color transition */
        }

        .button:hover {
            background-color: #ff4d4f; /* Darker shade on hover */
        }
    </style>
    <script>
        // Redirect to home page after 5 seconds
        setTimeout(function() {
            window.location.href = "orderPlaced.jsp"; // Change to your home page URL
        }, 5000);
    </script>
</head>
<body>
    <div class="container">
        <h1>Order Confirmation</h1>
        <%
            HttpSession newsession = request.getSession();
            String customerName = (String) session.getAttribute("customerName");
            String orderId = (String) session.getAttribute("orderId");
            String transactionId = (String) session.getAttribute("transactionId");
            String orderDate = (String) session.getAttribute("orderDate");
            Double totalAmount = (Double) session.getAttribute("totalAmount");
            String shippingAddress = (String) session.getAttribute("shippingAddress");
        %>
        <p>Thank you, <%= customerName != null ? customerName : "Customer" %>!</p>
        <p>Your order has been successfully placed.</p>
        <div class="order-details">
            <p><strong>Order ID:</strong> <%= orderId != null ? orderId : "N/A" %></p>
            <p><strong>Transaction ID:</strong> <%= transactionId != null ? transactionId : "N/A" %></p>
            <p><strong>Order Date:</strong> <%= orderDate != null ? orderDate : "N/A" %></p>
            <p><strong>Total Amount:</strong> ₹<%= totalAmount != null ? totalAmount : "0.00" %></p>
            <p><strong>Shipping Address:</strong> <%= shippingAddress != null ? shippingAddress : "N/A" %></p>
        </div>
    </div>
</body>
</html>
