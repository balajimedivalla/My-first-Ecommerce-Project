package Com.Revshop.servlet;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.Map;
//
//@WebServlet("/RemoveFromCartServlet")
//public class RemoveFromCartServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
//
//        if (cart != null) {
//            int productId = Integer.parseInt(request.getParameter("productId"));
//            cart.remove(productId); // Remove the product from the cart
//            session.setAttribute("cart", cart); // Update the session cart
//        }
//
//        // Redirect back to the cart page
//        response.sendRedirect("cart.jsp");
//    }
//}

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the product ID to remove from the cart
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Get the cart from the session
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(productId)) {
            cart.remove(productId);
        }

        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
}

