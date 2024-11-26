package Com.Revshop.servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get payment details from the request
        String cardNumber = request.getParameter("cardNumber");
        String cardHolderName = request.getParameter("cardHolderName");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Simulate a successful payment
        boolean paymentSuccess = true; // You can add more realistic logic here

        if (paymentSuccess) {
            // Forward to the checkout processing servlet
            request.getRequestDispatcher("ProcessCheckoutServlet").forward(request, response);
        } else {
            // Handle payment failure (optional)
            request.setAttribute("errorMessage", "Payment failed. Please try again.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }
}
