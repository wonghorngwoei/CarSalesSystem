package controller;

import facade.CustomerFacade;
import facade.SalesmanFacade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.Salesman;

@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    @EJB
    private SalesmanFacade salesmanFacade;

    @EJB
    private CustomerFacade customerFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // Get the values submitted in the form
            String username = request.getParameter("x1");
            String password = request.getParameter("x2");
            String email = request.getParameter("x3");
            String name = request.getParameter("x4");
            String age = request.getParameter("x5");
            String hpnumber = request.getParameter("x6");
            String gender = request.getParameter("x7");
            String usertype = request.getParameter("x8");

            try {
                switch (usertype) {
                    case "salesman":
                        // Check if the username already exists
                        Salesman found = salesmanFacade.findBySalesmanUsername(username);
                        if (found != null) {
                            throw new IllegalArgumentException("Username already exists");
                        }
                        // Create a new Salesman instance with the submitted values
                        Salesman salesman = new Salesman();
                        salesman.setUsername(username);
                        salesman.setPassword(password);
                        salesman.setEmail(email);
                        salesman.setName(name);
                        salesman.setAge(age);
                        salesman.setHpnumber(hpnumber);
                        salesman.setGender(gender);
                        salesman.setStatus("Pending");
                        salesman.setUsertype("salesman");
                        salesmanFacade.create(salesman);
                        break;
                    case "customer":
                        // Check if the username already exists
                        Customer found1 = customerFacade.findByCustomerUsername(username);
                        if (found1 != null) {
                            throw new IllegalArgumentException("Username already exists");
                        }
                        // Create a new Customer instance with the submitted values
                        Customer customer = new Customer();
                        customer.setUsername(username);
                        customer.setPassword(password);
                        customer.setEmail(email);
                        customer.setName(name);
                        customer.setAge(age);
                        customer.setHpnumber(hpnumber);
                        customer.setGender(gender);
                        customer.setStatus("Pending");
                        customer.setUsertype("customer");

                        customerFacade.create(customer);
                        break;
                    default:
                        System.out.println("Invalid user type!");
                        break;
                }
                // Forward the user to the homepage with a success message
                request.getSession().setAttribute("successMessage", "Successfully registered, you may try to login from the homepage now. Thank you!");
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } catch (IllegalArgumentException e) {
                // If there was an error creating the account, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, the username \"" + username + "\" is already taken");
                request.getRequestDispatcher("homepage.jsp").forward(request, response);
            } catch (IOException | ServletException e) {
                // If there was an error creating the account, display an error message to the user
                request.setAttribute("errorMessage", "Sorry, there was an error creating your account. Please try again.");
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
