<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Buddy - Manage Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .nav {
            margin: 20px 0;
        }
        .nav a {
            margin: 0 15px;
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: #0056b3;
        }
        .nav a:hover {
            background-color: #003f7f;
        }
        .message {
            text-align: center;
            margin: 20px 0;
            font-size: 18px;
            color: #333;
        }
        .add-product-form {
            display: none; /* Hide the form initially */
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            margin: 20px auto;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .add-product-form label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .add-product-form input {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .add-product-form button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .add-product-form button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<!-- Header Section -->
<div class="header">
    <h2>Welcome to RevShop, Buddy!</h2>
    <div class="profile">
        <% 
            String firstName = (String) session.getAttribute("firstName");
            if (firstName != null) {
        %>
            Welcome, <%= firstName %>! 
        <% 
            } else { 
        %>
            Welcome, Guest!
        <% 
            } 
        %>
    </div>
    <div class="nav">
        <a href="#" onclick="toggleForm()">Add Product</a>
        <a href="ManageProducts.jsp">Manage Products</a>
        <a href="null">View Orders</a>
        <a href="Signoutjsp.jsp">Signout</a>
    </div>
</div>

<h1>Seller Panel</h1>

<!-- Message Display -->
<div class="message" id="welcomeMessage">
    Welcome to RevShop, Buddy! You are just one step away from managing and adding products.
</div>

<!-- Add Product Form -->
<div class="add-product-form" id="addProductForm">
   <form method="post" action="AddProduct">
       <label for="name">Product Name</label>
       <input type="text" id="name" name="name" placeholder="Enter product name" required>

       <label for="description">Description</label>
       <input type="text" id="description" name="description" placeholder="Enter product description" required>

       <label for="price">Price</label>
       <input type="number" id="price" name="price" placeholder="Enter product price" required>

       <label for="imageUrl">Image URL</label>
       <input type="text" id="imageUrl" name="imageUrl" placeholder="Enter product image URL" required>

       <button type="submit">Add Product</button>
   </form>
</div>

<script>
    // Function to toggle the visibility of the add product form
    function toggleForm() {
        const form = document.getElementById("addProductForm");
        const message = document.getElementById("welcomeMessage");
        if (form.style.display === "none" || form.style.display === "") {
            form.style.display = "block"; // Show the form
            message.style.display = "none"; // Hide the welcome message
        } else {
            form.style.display = "none"; // Hide the form
            message.style.display = "block"; // Show the welcome message
        }
    }

    // Initial display setup
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("addProductForm");
        form.style.display = "none"; // Ensure the form is hidden on load
    });
</script>

</body>
</html>
