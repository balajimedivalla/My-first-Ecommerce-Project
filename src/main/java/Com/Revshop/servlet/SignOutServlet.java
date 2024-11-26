//package Com.Revshop.servlet;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//@WebServlet("/SignOutServlet")
//public class SignOutServlet extends HttpServlet {
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Invalidate the session to log the user out
//        HttpSession session = request.getSession(false);
//        if (session != null) {
//            session.invalidate(); // Invalidate the session
//        }
//        
//        // Redirect to the home page or login page
//        response.sendRedirect("index.jsp"); // Change this to your desired page after sign-out
//    }
//}
