package Com.Revshop.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve the product ID from the request
        String id = request.getParameter("id");

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/revshop"; 
        String user = "root"; //
        String password = "root"; //

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the connection
            conn = DriverManager.getConnection(url, user, password);
            
            // Prepare the DELETE statement
            pstmt = conn.prepareStatement("DELETE FROM products WHERE id = ?");
            pstmt.setInt(1, Integer.parseInt(id));
            // Execute the delete operation
            int rowsAffected = pstmt.executeUpdate();

            // Check if the delete was successful
            if (rowsAffected > 0) {
                System.out.println("Product deleted successfully.");
            } else {
                System.out.println("No product found with the given ID.");
            }

            // Redirect back to the products page
            response.sendRedirect("ManageProducts.jsp");
        } catch (NumberFormatException e) {
            // Handle potential number format issues
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid ID format");
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error occurred");
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
