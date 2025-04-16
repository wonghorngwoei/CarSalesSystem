package controller;

import facade.CarFacade;
import facade.CustomerFacade;
import facade.FeedbackFacade;
import facade.SalesmanFacade;
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
import model.Salesman;
import model.Transactions;

@WebServlet(name = "SalesmanDashboardFunction", urlPatterns = {"/SalesmanDashboardFunction"})
public class SalesmanDashboardFunction extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private TransactionsFacade transactionsFacade;

    @EJB
    private CarFacade carFacade;

    @EJB
    private SalesmanFacade salesmanFacade;

    @EJB
    private CustomerFacade customerFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("username") == null) {
            // the user is not logged in, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/homepage.jsp");
            return;
        }

        System.out.println("Servlet loaded.");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            switch (action) {
                case "edit":
                    String username = (String) session.getAttribute("username");
                    //retrieve the user information from the database using JPA
                    Salesman account = salesmanFacade.findBySalesmanUsername(username);
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
                    salesmanFacade.edit(account);
                    // Redirect the user to the profile page with a success message
                    request.setAttribute("message", "Profile updated successfully!");
                    break;
                case "sales": {
                    Long id = (Long) session.getAttribute("id");
                    Long customerId = Long.parseLong(request.getParameter("customerId"));
                    Long carId = Long.parseLong(request.getParameter("carId"));
                    String comments = request.getParameter("comments");
                    // Find the relevant entities from the database
                    Salesman salesperson = salesmanFacade.find(id);
                    Customer customers = customerFacade.find(customerId);
                    Car car = carFacade.find(carId);
                    System.out.println(car);
                    try {
                        Feedback feedback = new Feedback();
                        feedback.setCustomer(customers);
                        feedback.setFeedback(null);
                        feedback.setRating(null);
                        feedbackFacade.create(feedback);

                        // Update user profile information
                        Transactions trans = new Transactions();
                        trans.setCustomer(customers);
                        trans.setSalesman(salesperson);
                        trans.setCar(car);
                        trans.setFeedback(feedback);
                        trans.setComment(comments);
                        trans.setTransStatus("Pending");

                        // persist the transaction object to the database
                        transactionsFacade.create(trans);
                    } catch (NumberFormatException e) {
                        System.out.print("Something went wrong when creating transaction" + e);
                    }       //retrieve the user information from the database using JPA
                    car.setStatus("Booked");
                    carFacade.edit(car);
                    request.getSession().setAttribute("successMessage", "Successfully book for the car!");
                    break;
                }
                case "pay": {
                    Long carId = Long.parseLong(request.getParameter("carId"));
                    Long transId = Long.parseLong(request.getParameter("transId"));
                    Car car = carFacade.find(carId);
                    Transactions trans = transactionsFacade.find(transId);
                    //retrieve the user information from the database using JPA
                    car.setStatus("Paid");
                    trans.setTransStatus("Completed");
                    transactionsFacade.edit(trans);
                    carFacade.edit(car);

                    request.getSession().setAttribute("successMessage", "Successfully paid for the car!");
                    break;
                }
                case "cancel": {
                    Long carId = Long.parseLong(request.getParameter("carId"));
                    Long transId = Long.parseLong(request.getParameter("transId"));
                    Transactions trans = transactionsFacade.find(transId);

                    trans.setTransStatus("Cancelled");
                    transactionsFacade.edit(trans);

                    Feedback cancelFeedback = trans.getFeedback();
                    cancelFeedback.setFeedback("Transaction Cancelled");
                    cancelFeedback.setRating("Transaction Cancelled");
                    feedbackFacade.edit(cancelFeedback);

                    Car car = carFacade.find(carId);
                    car.setStatus("Cancelled");
                    carFacade.edit(car);
                    break;
                }
                case "available": {
                    Long carId = Long.parseLong(request.getParameter("carId"));
                    Car car = carFacade.find(carId);
                    System.out.println(car);
                    //retrieve the user information from the database using JPA
                    car.setStatus("Available");
                    carFacade.edit(car);

                    request.setAttribute("successMessage", "Successfully set the car status to 'Available'");
                    break;
                }
                default:
                    break;
            }
            String username = (String) session.getAttribute("username");
            System.out.println(action);

            //retrieve the user information from the database using JPA
            Salesman account = salesmanFacade.findBySalesmanUsername(username);
            List<Car> carList = carFacade.findAllCars();
            List<Car> cancelledCarList = carFacade.findAllCancelledCars();
            List<Customer> custList = customerFacade.findAllCustomer();
            List<Transactions> transList = transactionsFacade.findAllTransactionsBySalesman(account);

            //set the user information in the request attribute
            request.setAttribute("name", account.getName());
            request.setAttribute("age", String.valueOf(account.getAge()));
            request.setAttribute("email", account.getEmail());
            request.setAttribute("hpnumber", account.getHpnumber());
            request.setAttribute("gender", account.getGender());

            // Set the user type in the session
            session.setAttribute("username", account.getUsername());
            request.setAttribute("carList", carList);
            request.setAttribute("cancelledCarList", cancelledCarList);
            request.setAttribute("custList", custList);
            request.setAttribute("transList", transList);
            // Redirect to the appropriate page
            request.getRequestDispatcher("salesmandashboard.jsp?id=" + session.getAttribute("id")).forward(request, response);

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
