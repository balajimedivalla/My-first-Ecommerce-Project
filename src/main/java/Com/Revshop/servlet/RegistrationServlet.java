package Com.Revshop.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/revshop"; 
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "root";

    // Handle POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");
        String role = request.getParameter("UserRole");
        String gender = request.getParameter("Gender");
        String mobileNumber = request.getParameter("MobileNumber");

        // Prepare SQL statements based on user role
        String checkEmailSQL = "SELECT * FROM ";
        String insertSQL = "";
        
        if ("buyer".equalsIgnoreCase(role)) { 
            checkEmailSQL += "Buyers WHERE Email = ?";
            insertSQL = "INSERT INTO Buyers (FirstName, LastName, Email, Password, Gender, MobileNumber) VALUES (?, ?, ?, ?, ?, ?)";
        } else if ("seller".equalsIgnoreCase(role)) { 
            checkEmailSQL += "Seller WHERE Email = ?";
            insertSQL = "INSERT INTO Seller (FirstName, LastName, Email, Password, Gender, MobileNumber) VALUES (?, ?, ?, ?, ?, ?)";
        }

        if (!insertSQL.isEmpty()) {
            try { 
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Check if the email already exists
                PreparedStatement checkStmt = conn.prepareStatement(checkEmailSQL);
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Email exists, set error message and forward to register.jsp
                    request.setAttribute("errorMessage", "Email already exists. Please use a different email.");
                    request.getRequestDispatcher("Registration.jsp").forward(request, response);
                } else {
                    // Email does not exist, proceed with registration
                    PreparedStatement stmt = conn.prepareStatement(insertSQL);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, email);
                    stmt.setString(4, password);
                    stmt.setString(5, gender);
                    stmt.setString(6, mobileNumber);
                    stmt.executeUpdate();

                    // Redirect to success page
                    response.sendRedirect("Sucess.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle exception appropriately
            }
        }
    }
}
