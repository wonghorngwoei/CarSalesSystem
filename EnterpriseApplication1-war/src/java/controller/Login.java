package controller;

import facade.CustomerFacade;
import facade.ManagingStaffFacade;
import facade.SalesmanFacade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.ManagingStaff;
import model.Salesman;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @EJB
    private SalesmanFacade salesmanFacade;

    @EJB
    private ManagingStaffFacade managingStaffFacade;

    @EJB
    private CustomerFacade customerFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String username = request.getParameter("x");
            String password = request.getParameter("y");

            try {
                ManagingStaff managerEntity = managingStaffFacade.loginAsManagingStaff(username, password);
                Customer customerEntity = customerFacade.loginAsCustomer(username, password);
                Salesman salesmanEntity = salesmanFacade.loginAsSalesman(username, password);

                HttpSession session = request.getSession();
                String usertype;

                if (managerEntity != null) {
                    ManagingStaff account = managerEntity;
                    session.setAttribute("id", account.getId());
                    session.setAttribute("username", account.getUsername());
                    session.setAttribute("name", account.getName());
                    usertype = "managingStaff";

                } else if (customerEntity != null) {
                    Customer account = customerEntity;
                    session.setAttribute("id", account.getId());
                    session.setAttribute("username", account.getUsername());
                    usertype = "customer";

                } else if (salesmanEntity != null) {
                    Salesman account = salesmanEntity;
                    session.setAttribute("id", account.getId());
                    session.setAttribute("username", account.getUsername());
                    usertype = "salesman";

                } else {
                    request.getSession().setAttribute("error", "Invalid username or password.");
                    throw new Exception("Invalid username or password.");
                }

                switch (usertype) {
                    case "customer":
                        if (customerEntity.getStatus().equals("Pending")) {
                            request.getSession().setAttribute("error", "Status is still pending approval from Managing Staff. Please wait for approval.");
                            request.getRequestDispatcher("homepage.jsp").forward(request, response);
                        } else if (customerEntity.getStatus().equals("Active")) {
                            response.sendRedirect(request.getContextPath() + "/CustomerDashboardFunction?action=success");
                            request.getSession().setAttribute("successMessage", "Successfully logged in as Customer!");
                        }
                        break;
                    case "salesman":
                        if (salesmanEntity.getStatus().equals("Pending")) {
                            request.getSession().setAttribute("error", "Status is still pending approval from Managing Staff. Please wait for approval.");
                            request.getRequestDispatcher("homepage.jsp").forward(request, response);
                        } else if (salesmanEntity.getStatus().equals("Active")) {
                            response.sendRedirect(request.getContextPath() + "/SalesmanDashboardFunction?action=success");
                            request.getSession().setAttribute("successMessage", "Successfully logged in as Salesman!");
                        }
                        break;
                    case "managingStaff":
                        response.sendRedirect(request.getContextPath() + "/ManagingStaffDashboardFunction?action=success");
                        request.getSession().setAttribute("successMessage", "Successfully logged in as Managing Staff!");
                        break;
                    default:
                        break;
                }

            } catch (Exception e) {
                // Display error message
                request.setAttribute("error", e.getMessage());
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
