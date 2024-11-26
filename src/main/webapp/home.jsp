<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RevShop - Welcome</title>
    <style> 
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://png.pngtree.com/thumb_back/fh260/background/20201016/pngtree-glitter-background-with-star-in-orange-light-color-image_419586.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navigation bar styles */
        nav {
            background-color: rgba(13, 72, 130, 0.8);
            width: 100%;
            padding: 15px 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: sticky;
            top: 0;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }

        nav ul li {
            margin: 0 20px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 20px;
            transition: background-color 0.3s ease, color 0.3s ease;
            border-radius: 5px;
        }

        nav ul li a:hover {
            background-color: #1E90FF;
            color: #fff;
        }

        /* Disabled styles for Home and Contact Us */
        nav ul li a.disabled {
            pointer-events: none;
            cursor: default;
            opacity: 0.6;
            background-color: #666;
        }

        /* Center content styles */
        .welcome {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        .welcome h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .welcome p {
            font-size: 24px;
        }
    </style>
</head>
<body>

    <!-- Navigation bar -->
    <nav>
        <ul>
            <li><a href="Home.jsp" class="disabled">Home</a></li> <!-- Disabled -->
            <li><a href="Registration.jsp">Registration</a></li>
            <li><a href="Contact.jsp" class="disabled">Contact Us</a></li> <!-- Disabled -->
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>

    <!-- Welcome content in the center -->
    <div class="welcome">
        <h1>Welcome to RevShop</h1>
        <p>Unmatched variety, unbeatable prices just for you!</p>
    </div>

</body>
</html>
