package Com.Revshop.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        // Initialize cart if it is null
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Get the action parameter
        String action = request.getParameter("action");
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity"); // Get quantity

        try {
            if (productIdParam != null && quantityParam != null) {
                int productId = Integer.parseInt(productIdParam);
                int quantity = Integer.parseInt(quantityParam); // Convert quantity to an integer

                if ("remove".equals(action)) {
                    // Remove the product from the cart
                    cart.remove(productId);
                } else if ("add".equals(action)) {
                    // Handle adding to the cart
                    // Add or update the quantity in the cart
                    cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
                }

                // Update the session cart
                session.setAttribute("cart", cart);
            }
        } catch (NumberFormatException e) {
            // Log the exception and return an error message to the user
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or quantity.");
            return;
        }

        // Redirect back to the MainView.jsp after adding/removing the product
        response.sendRedirect("MainView.jsp");
    }
}
