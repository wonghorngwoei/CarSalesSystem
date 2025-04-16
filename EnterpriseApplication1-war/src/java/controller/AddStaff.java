package controller;

import facade.ManagingStaffFacade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ManagingStaff;

@WebServlet(name = "AddStaff", urlPatterns = {"/AddStaff"})
public class AddStaff extends HttpServlet {

    @EJB
    private ManagingStaffFacade managingStaffFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("Servlet loaded.");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("Step 1 passed.");
            // Get the values submitted in the form
            String username = request.getParameter("x11");
            String password = request.getParameter("x12");
            String email = request.getParameter("x13");
            String name = request.getParameter("x14");
            String hpnumber = request.getParameter("x15");
            try {
                System.out.println("Step 2 passed.");
                // Check if the username already exists
                ManagingStaff found = managingStaffFacade.findByMgmtStaffUsername(username);
                if (found != null) {
                    throw new IllegalArgumentException("Username already exists");
                }

                // Create a new ManagingStaff instance with the submitted values
                ManagingStaff account = new ManagingStaff();
                account.setUsername(username);
                account.setPassword(password);
                account.setEmail(email);
                account.setName(name);
                account.setHpnumber(hpnumber);
                account.setUsertype("managingStaff");

                managingStaffFacade.create(account);

                System.out.println("Step 3 passed.");
                // Forward the user to the homepage with a success message
                request.getSession().setAttribute("successMessage", "Successfully registered, you may ask the staff to login from the homepage now. Thank you!");
                request.getRequestDispatcher("/ManagingStaffDashboardFunction?action=success").forward(request, response);

            } catch (IllegalArgumentException e) {
                System.out.println("Step 2 Error.");
                // If the username already exists, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, the username \"" + username + "\" is already taken");
                System.out.println("Username Taken!");
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } catch (Exception e) {
                System.out.println("Step 3 Error.");
                // If there was an error creating the account, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, there was an error creating your account. Please try again.");
                System.out.println("Error!");
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            }
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
