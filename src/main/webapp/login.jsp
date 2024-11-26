	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Login - RevShop</title>
	    <style>
	        body {
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            height: 100vh;
	            margin: 0;
	            background-color: #f0f0f0;
	            font-family: Arial, sans-serif;
	            background-image: url('https://redpithemes.com/Documentation/assets/img/page_bg/page_bg_blur02.jpg');
	        }
	        form {
	            background-color: white;
	            padding: 20px;
	            border-radius: 5px;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	        }
	        input[type="text"], input[type="password"], select {
	            width: 100%;
	            padding: 15px;
	            margin: 10px 0;
	            border: 1px solid #ccc;
	            border-radius: 3px;
	            box-sizing: border-box;
	            font-size: 16px;
	        }
	        input[type="submit"] {
	            background-color: #5cb85c;
	            color: white;
	            border: none;
	            padding: 15px;
	            border-radius: 3px;
	            cursor: pointer;
	            font-size: 16px;
	        }
	        input[type="submit"]:hover {
	            background-color: #4cae4c;
	        }
	        .forgot-password {
	            display: block;
	            margin-top: 10px;
	            text-align: center;
	        }
	    </style>
	</head>
	<body>
	
	    <form action="Loginservlet" method="post"> 
	        <h2>Login</h2>
	        <input type="text" name="email" placeholder="Email" required>
	        <input type="password" name="password" placeholder="Password" required>
	        <select name="role" required>
	            <option value="buyer">Buyer</option>
	            <option value="seller">Seller</option>
	        </select>
	        <input type="submit" value="Login">
	        <a href="forgotPassword.jsp" class="forgot-password">Forgot Password?</a>
	    </form>
	
	</body>
	</html>
