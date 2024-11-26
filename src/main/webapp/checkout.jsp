<%@ page import="java.util.Map" %>
<%
    // Clear the cart after checkout
    session.removeAttribute("cart"); // This will remove the cart from the session

    String successMessage = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - RevShop</title>
    <style>
        /* CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        .form-container {
            width: 50%;
            margin: auto;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }
        .submit-button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        .card-details {
            display: none;
        }
    </style>
    <script>
        function toggleCardDetails() {
            var paymentType = document.getElementById("paymentType").value;
            var cardDetails = document.getElementById("cardDetails");
            if (paymentType === "credit" || paymentType === "debit") {
                cardDetails.style.display = "block";
            } else {
                cardDetails.style.display = "none";
            }
        }
    </script>
</head>

<body>
    <h1>Checkout</h1>
    <div class="form-container">
        <form action="ProcessCheckoutServlet" method="post">
            <label for="customerName">Customer Name:</label>
            <input type="text" id="customerName" name="customerName" required>

            <label for="customerAddress">Shipping Address:</label>
            <input type="text" id="customerAddress" name="customerAddress" required>

            <label for="mobileNumber">Mobile Number:</label>
            <input type="text" id="mobileNumber" name="mobileNumber" required>

            <label for="paymentType">Payment Method:</label>
            <select id="paymentType" name="paymentType" onchange="toggleCardDetails()" required>
                <option value="cash">Cash on Delivery</option>
                <option value="credit">Credit Card</option>
                <option value="debit">Debit Card</option>
            </select>

            <div id="cardDetails" class="card-details">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" pattern="\d{16}" placeholder="16-digit card number">
                
                <label for="expiryDate">Expiry Date:</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY">
                
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" pattern="\d{3}" placeholder="3-digit CVV">
            </div>

            <input type="hidden" name="totalAmount" value="<%= request.getParameter("totalAmount") %>">
            
            <button type="submit" class="submit-button">Place Order</button>
        </form>
    </div>
</body>
</html>
