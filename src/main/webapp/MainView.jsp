<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - RevShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            background-image: url("https://img.freepik.com/free-photo/grunge-gray-concrete-textured-background_53876-129715.jpg");
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: black;
        }

        /* Header styles */
        .header {
            background-color: #007bff;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .header a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
        }

        .header a:hover {
            text-decoration: underline;
        }

        .search-container {
            display: flex;
            align-items: center;
            flex-grow: 1;
            justify-content: center;
        }

        .search-input {
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 250px;
            margin-right: 10px;
        }

        .search-button {
            padding: 8px 12px;
            background-color: #28a745;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-button:hover {
            opacity: 0.8;
        }

        .product-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            padding: 20px;
        }

        .product {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 10px;
            width: 300px;
            text-align: center;
        }

        .product img {
            width: 200px;
            height: 100px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 15px;
            background-color: #f0f0f0;
        }

        .product h2 {
            font-size: 22px;
            margin: 10px 0;
        }

        .product p {
            font-size: 16px;
            margin: 5px 0;
        }

        .price {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
            color: #28a745;
        }

        .add-to-cart, .buy-now {
            display: inline-block;
            padding: 10px 20px;
            color: white;
            background-color: Green;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }

        .add-to-cart:hover {
            opacity: 0.8;
        }
        .buy-now:hover {
            opacity: 0.5;
        }

        /* Adjust size of quantity input box */
        .quantity-input {
            width: 50px;
            margin-right: 10px;
        }
    </style>
</head>

<body>

    <!-- Header Section -->
    <div class="header">
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
        <div class="search-container">
            <form action="MainView.jsp" method="get">
                <input type="text" class="search-input" name="query" placeholder="Search for products...">
                <button type="submit" class="search-button">Search</button>
            </form>
        </div>

        <%
            // Fetch the number of items in the cart dynamically
            int cartItemCount = 0;

            // Assuming we store cart data in session, this can be adjusted
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
                session.setAttribute("cart", cart);
            } else {
                for (int quantity : cart.values()) {
                    cartItemCount += quantity;  // Total quantity of items in the cart
                }
            }
        %>

        <a href="cart.jsp">Cart (<%= cartItemCount %>)</a>
        <a href="Signoutjsp.jsp">Sign Out</a> <!-- Link to your Sign Out servlet -->
    </div>

    <h1>Welcome To RevShop Products</h1>

    <div class="product-container">
        <%
            // Database connection parameters
            String DB_URL = "jdbc:mysql://localhost:3306/revshop";
            String DB_USER = "root";
            String DB_PASSWORD = "root";
            String query = request.getParameter("query"); // Get search query

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                // Load MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection
                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                
                // Query to get all products, filter if search query is provided
                String sql = "SELECT * FROM products";
                if (query != null && !query.isEmpty()) {
                    sql += " WHERE name LIKE ?";
                }
                
                preparedStatement = connection.prepareStatement(sql);
                if (query != null && !query.isEmpty()) {
                    preparedStatement.setString(1, "%" + query + "%"); // Use prepared statement to avoid SQL injection
                }

                resultSet = preparedStatement.executeQuery();
                
                // Loop through the products and display them
                while (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String description = resultSet.getString("description");
                    double price = resultSet.getDouble("price");
                    String imageUrl = resultSet.getString("image_url");
                    int productId = resultSet.getInt("id");
        %>

                <div class="product">
                    <img src="<%= imageUrl %>" alt="<%= name %> Image">
                    <h2><%= name %></h2>
                    <p class="description"><%= description %></p>
                    <p class="price">Price: ₹<%= price %></p>

                    <!-- Add to Cart form -->
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="price" value="<%= price %>">
                        
                        <!-- Quantity Input -->
                        <label for="quantity_<%= productId %>">Quantity:</label>
                        <input type="number" id="quantity_<%= productId %>" name="quantity" class="quantity-input" value="1" min="1" required>
                        
                        <!-- Add to Cart action -->
                        <input type="hidden" name="action" value="add">
                        
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>

                    <!-- Buy Now Button -->
                    <form action="checkout.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="price" value="<%= price %>">
                        
                        <button type="submit" class="buy-now">Buy Now</button>
                    </form>
                </div>

        <%
                }
            } catch (Exception e) {
                out.println("<p>Error occurred while fetching products: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

</body>
</html>
