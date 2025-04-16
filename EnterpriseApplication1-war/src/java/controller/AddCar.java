package controller;

import facade.CarFacade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;

@WebServlet(name = "AddCar", urlPatterns = {"/AddCar"})
public class AddCar extends HttpServlet {

    @EJB
    private CarFacade carFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("Servlet loaded.");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("Step 1 passed.");
            // Get the values submitted in the form
            String make = request.getParameter("carmake");
            String model = request.getParameter("carmodel");
            String chassis = request.getParameter("carchassis");
            String caryear = request.getParameter("caryear");
            String color = request.getParameter("carcolor");
            int price = Integer.parseInt(request.getParameter("carprice"));
            String description = request.getParameter("cardesc");
            System.out.println("Step 2 passed.");

            try {
                System.out.println("Step 3 passed.");

                // Create a new Car instance with the submitted values
                Car details = new Car();
                details.setMake(make);
                details.setModel(model);
                details.setChassis(chassis);
                details.setCaryear(caryear);
                details.setColor(color);
                details.setPrice(price);
                details.setDescription(description);
                details.setStatus("Available");

                carFacade.create(details);

                System.out.println("Step 4 passed.");
                // Forward the user to the homepage with a success message
                request.getSession().setAttribute("successMessage", "Successfully registered. Thank you!");
                request.getRequestDispatcher("/ManagingStaffDashboardFunction?action=success").forward(request, response);

            } catch (IllegalArgumentException e) {
                System.out.println("Step 2 Error.");
                // If the username already exists, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, the car chassis \"" + chassis + "\" has already been registered");
                System.out.println("Chassis Taken!");
                request.getRequestDispatcher("ManagingStaffDashboardFunction").forward(request, response);
            } catch (IOException | ServletException e) {
                System.out.println("Step 3 Error.");
                // If there was an error creating the account, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, there was an error creating your account. Please try again.");
                System.out.println("Error!");
                request.getRequestDispatcher("ManagingStaffDashboardFunction").forward(request, response);
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
