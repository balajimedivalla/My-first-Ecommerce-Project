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
import javax.servlet.http.HttpSession;

@WebServlet("/Loginservlet")
public class Loginservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/revshop";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String query = null;
            if ("buyer".equalsIgnoreCase(role)) {
                query = "SELECT FirstName FROM Buyers WHERE Email = ? AND Password = ?";
            } else if ("seller".equalsIgnoreCase(role)) {
                query = "SELECT FirstName FROM Seller WHERE Email = ? AND Password = ?";
            }

            if (query == null) {
                request.setAttribute("errorMessage", "Invalid role selected.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("Email", email);
                session.setAttribute("role", role);

                // Set FirstName in session
                String firstName = rs.getString("FirstName");
                session.setAttribute("firstName", firstName);

                // Redirect based on role
                if ("buyer".equalsIgnoreCase(role)) {
                    response.sendRedirect("MainView.jsp"); // Redirect Buyer to MainView.jsp
                } else if ("seller".equalsIgnoreCase(role)) {
                    response.sendRedirect("Productadd.jsp"); // Redirect Seller to ProductAdd.jsp
                }
            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
