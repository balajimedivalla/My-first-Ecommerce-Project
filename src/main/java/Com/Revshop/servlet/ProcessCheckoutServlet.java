package Com.Revshop.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ProcessCheckoutServlet")
public class ProcessCheckoutServlet extends HttpServlet {
    private Connection connection;

    @Override
    public void init() throws ServletException {
        super.init();
        connection = DatabaseConnection.getConnection(); // Initialize your DB connection
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("customerName");
        String customerAddress = request.getParameter("customerAddress");
        String mobileNumber = request.getParameter("mobileNumber");
        String paymentType = request.getParameter("paymentType");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Generate unique order ID and transaction ID
        String transactionId = "TXN" + System.currentTimeMillis();
        String orderId = "ORD" + System.currentTimeMillis();
        String orderDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        boolean paymentSuccess = true; // Simulating payment success

        if (paymentSuccess) {
            PreparedStatement preparedStatement = null;
            PreparedStatement itemStatement = null;

            try {
                // Insert order details
                String sql = "INSERT INTO orders (customer_name, customer_address, mobile_number, total_amount, payment_type, order_date, transaction_id, order_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, customerName);
                preparedStatement.setString(2, customerAddress);
                preparedStatement.setString(3, mobileNumber);
                preparedStatement.setDouble(4, totalAmount);
                preparedStatement.setString(5, paymentType);
                preparedStatement.setString(6, orderDate);
                preparedStatement.setString(7, transactionId);
                preparedStatement.setString(8, orderId);
                preparedStatement.executeUpdate();

                // Insert each item into the order_items table
                String[] itemNames = request.getParameterValues("itemName"); // Example input from the form
                String[] quantities = request.getParameterValues("quantity");
                String[] prices = request.getParameterValues("price");

                if (itemNames != null) {
                    String itemSql = "INSERT INTO order_items (order_id, item_name, quantity, price) VALUES (?, ?, ?, ?)";
                    itemStatement = connection.prepareStatement(itemSql);

                    for (int i = 0; i < itemNames.length; i++) {
                        itemStatement.setString(1, orderId);
                        itemStatement.setString(2, itemNames[i]);
                        itemStatement.setInt(3, Integer.parseInt(quantities[i]));
                        itemStatement.setBigDecimal(4, new java.math.BigDecimal(prices[i]));
                        itemStatement.addBatch();
                    }

                    itemStatement.executeBatch();
                }

                // Store order details in session to retrieve later
                HttpSession session = request.getSession();
                session.setAttribute("customerName", customerName); // Store customer name in session
                session.setAttribute("orderId", orderId); // Store order ID in session
                session.setAttribute("transactionId", transactionId); // Store transaction ID in session
                session.setAttribute("orderDate", orderDate); // Store order date in session
                session.setAttribute("totalAmount", totalAmount); // Store total amount in session
                session.setAttribute("shippingAddress", customerAddress); // Store shipping address in session

                // Forward to confirmation page
                RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation.jsp");
                dispatcher.forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error processing order: " + e.getMessage());
            } finally {
                // Close the prepared statements
                try {
                    if (preparedStatement != null) preparedStatement.close();
                    if (itemStatement != null) itemStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.getWriter().println("<h2>Payment Failed. Please try again.</h2>");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
