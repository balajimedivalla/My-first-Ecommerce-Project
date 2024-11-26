package Com.Revshop.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceParam = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        // Debug: log inputs for troubleshooting
        System.out.println("ID: " + idParam);
        System.out.println("Name: " + name);
        System.out.println("Description: " + description);
        System.out.println("Price: " + priceParam);
        System.out.println("Image URL: " + imageUrl);

        // Validate inputs (check if any field is null or empty)
        if (idParam == null || idParam.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty() ||
            imageUrl == null || imageUrl.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields must be filled out.");
            return;
        }

        int id;
        double price;

        // Parse ID and price with error handling for invalid numbers
        try {
            id = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID.");
            return;
        }

        try {
            price = Double.parseDouble(priceParam.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Price must be a valid number.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Database connection parameters
        	  String url = "jdbc:mysql://localhost:3306/revshop"; // Replace with your database name
              String user = "root"; // Replace with your database username
              String password = "root"; //// Replace with your database password

            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection
            conn = DriverManager.getConnection(url, user, password);

            // Update SQL query to modify the product details
            String sql = "UPDATE products SET name=?, description=?, price=?, image_url=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setString(4, imageUrl);
            pstmt.setInt(5, id);

            // Execute the update statement
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product updated successfully.");
            } else {
                System.out.println("Product not found or not updated.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the product.");
        } finally {
            // Close resources
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        // Redirect back to manage products page
        response.sendRedirect("ManageProducts.jsp");
    }
}
