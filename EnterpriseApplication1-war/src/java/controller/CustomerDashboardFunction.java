package controller;

import facade.CarFacade;
import facade.CustomerFacade;
import facade.FeedbackFacade;
import facade.TransactionsFacade;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Car;
import model.Customer;
import model.Feedback;
import model.Transactions;

@WebServlet(name = "CustomerDashboardFunction", urlPatterns = {"/CustomerDashboardFunction"})
public class CustomerDashboardFunction extends HttpServlet {

    @EJB
    private TransactionsFacade transactionsFacade;

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private CarFacade carFacade;

    @EJB
    private CustomerFacade customerFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("username") == null) {
            // the user is not logged in, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/homepage.jsp");
            return;
        }

        System.out.println("Servlet loaded.");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            if (action.equals("edit")) {
                String username = (String) session.getAttribute("username");
                //retrieve the user information from the database using JPA
                Customer account = customerFacade.findByCustomerUsername(username);
                String name = request.getParameter("name");
                String age = request.getParameter("age");
                String email = request.getParameter("email");
                String hpnumber = request.getParameter("hpnumber");
                String gender = request.getParameter("gender");

                // Update user profile information
                account.setName(name);
                account.setAge(age);
                account.setEmail(email);
                account.setHpnumber(hpnumber);
                account.setGender(gender);

                // Save the changes to the database
                customerFacade.edit(account);
                System.out.println("Successfully Updated the Profile.");

                // Set the updated user information in the request attribute
                request.setAttribute("name", account.getName());
                request.setAttribute("age", String.valueOf(account.getAge()));
                request.setAttribute("email", account.getEmail());
                request.setAttribute("hpnumber", account.getHpnumber());
                request.setAttribute("gender", account.getGender());

                // Redirect the user to the profile page with a success message
                request.setAttribute("message", "Profile updated successfully!");

            } else if (action.equals("feedback")) {
                Long feedbackId = Long.parseLong(request.getParameter("feedbackId"));
                String feedback = request.getParameter("feedback");
                String rating = request.getParameter("rating");

                Feedback feedbacks = feedbackFacade.find(feedbackId);
                feedbacks.setFeedback(feedback);
                feedbacks.setRating(rating);
                feedbackFacade.edit(feedbacks);
            }
            String username = (String) session.getAttribute("username");
            //retrieve the user information from the database using JPA
            Customer account = customerFacade.findByCustomerUsername(username);
            List<Car> availableCarList = carFacade.findAllAvailableCars();
            List<Transactions> showCustTransList = transactionsFacade.findAllTransactionsByCustomer(account);
            System.out.println(account.getUsername() + ", Welcome");

            //set the user information in the request attribute
            request.setAttribute("name", account.getName());
            request.setAttribute("age", String.valueOf(account.getAge()));
            request.setAttribute("email", account.getEmail());
            request.setAttribute("hpnumber", account.getHpnumber());
            request.setAttribute("gender", account.getGender());
            request.setAttribute("availableCarList", availableCarList);
            request.setAttribute("showCustTransList", showCustTransList);
            // Set the user type in the session
            session.setAttribute("username", account.getUsername());
            // Redirect to the appropriate page
            request.getRequestDispatcher("customerdashboard.jsp?id=" + session.getAttribute("id")).forward(request, response);
        } catch (Exception e) {
            // Display error message
            request.setAttribute("error", e.getMessage());
            System.out.println("Hello error");
            response.sendRedirect("homepage.jsp");
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
