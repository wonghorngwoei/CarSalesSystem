package controller;

import facade.CarFacade;
import facade.CustomerFacade;
import facade.FeedbackFacade;
import facade.ManagingStaffFacade;
import facade.SalesmanFacade;
import facade.TransactionsFacade;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import model.ManagingStaff;
import model.Salesman;
import model.Transactions;

@WebServlet(name = "ManagingStaffDashboardFunction", urlPatterns = {"/ManagingStaffDashboardFunction"})
public class ManagingStaffDashboardFunction extends HttpServlet {

    @EJB
    private TransactionsFacade transactionsFacade;

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private SalesmanFacade salesmanFacade;

    @EJB
    private ManagingStaffFacade managingStaffFacade;

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private CarFacade carFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("Servlet loaded.");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            // the user is not logged in, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/homepage.jsp");
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            String username = request.getParameter("username");

            if (action.equals("editStaff")) {
                //retrieve the user information from the database using JPA
                ManagingStaff account = managingStaffFacade.findByMgmtStaffUsername(username);

                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String hpnumber = request.getParameter("hpnumber");

                // Update user profile information
                account.setPassword(password);
                account.setName(name);
                account.setEmail(email);
                account.setHpnumber(hpnumber);

                // Save the changes to the database
                managingStaffFacade.edit(account);

                request.getSession().setAttribute("successMessage", "Successfully updated the managing staff profile.");
            } else if (action.equals("editSalesman")) {
                //retrieve the user information from the database using JPA
                Salesman account = salesmanFacade.findBySalesmanUsername(username);

                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String age = request.getParameter("age");
                String email = request.getParameter("email");
                String hpnumber = request.getParameter("hpnumber");
                String gender = request.getParameter("gender");

                // Update user profile information
                account.setPassword(password);
                account.setName(name);
                account.setAge(age);
                account.setEmail(email);
                account.setHpnumber(hpnumber);
                account.setGender(gender);

                // Save the changes to the database
                salesmanFacade.edit(account);

                request.getSession().setAttribute("successMessage", "Successfully updated the salesman profile.");
            } else if (action.equals("editCustomer")) {
                //retrieve the user information from the database using JPA
                Customer account = customerFacade.findByCustomerUsername(username);

                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String age = request.getParameter("age");
                String email = request.getParameter("email");
                String hpnumber = request.getParameter("hpnumber");
                String gender = request.getParameter("gender");

                // Update user profile information
                account.setPassword(password);
                account.setName(name);
                account.setAge(age);
                account.setEmail(email);
                account.setHpnumber(hpnumber);
                account.setGender(gender);

                // Save the changes to the database
                customerFacade.edit(account);

                request.getSession().setAttribute("successMessage", "Successfully updated the customer profile.");
            } else if (action.equals("editCar")) {
                Long carId = Long.parseLong(request.getParameter("carId"));
                //retrieve the user information from the database using JPA
                Car cars = carFacade.find(carId);

                String make = request.getParameter("carmake");
                String model = request.getParameter("carmodel");
                String chassis = request.getParameter("carchassis");
                String caryear = request.getParameter("caryear");
                String color = request.getParameter("carcolor");
                int price = Integer.parseInt(request.getParameter("carprice"));
                String description = request.getParameter("cardesc");

                // Update user profile information
                cars.setMake(make);
                cars.setModel(model);
                cars.setChassis(chassis);
                cars.setCaryear(caryear);
                cars.setColor(color);
                cars.setPrice(price);
                cars.setDescription(description);

                // Save the changes to the database
                carFacade.edit(cars);

                request.getSession().setAttribute("successMessage", "Successfully updated the car information.");
            } else if (action.equals("deleteStaff")) {
                //retrieve the user information from the database using JPA
                ManagingStaff account = managingStaffFacade.findByMgmtStaffUsername(username);

                //Delete the selected account from the database
                managingStaffFacade.remove(account);

                request.getSession().setAttribute("successMessage", "Successfully deleted a managing staff.");
            } else if (action.equals("deleteSalesman")) {
                //retrieve the user information from the database using JPA
                Salesman account = salesmanFacade.findBySalesmanUsername(username);

                //Delete the selected account from the database
                salesmanFacade.remove(account);

                request.getSession().setAttribute("successMessage", "Successfully deleted a salesman.");
            } else if (action.equals("deleteCustomer")) {
                //retrieve the user information from the database using JPA
                Customer account = customerFacade.findByCustomerUsername(username);

                //Delete the selected account from the database
                customerFacade.remove(account);

                request.getSession().setAttribute("successMessage", "Successfully deleted a customer.");
            } else if (action.equals("deleteCar")) {
                Long delCarId = Long.parseLong(request.getParameter("id"));
                //retrieve the user information from the database using JPA
                Car cars = carFacade.find(delCarId);

                //Delete the selected account from the database
                carFacade.remove(cars);
                request.getSession().setAttribute("successMessage", "Successfully deleted a car.");
            } else if (action.equals("approveSalesman")) {
                //retrieve the user information from the database using JPA
                Salesman account = salesmanFacade.findBySalesmanUsername(username);
                //retrieve the user information from the database
                account.setStatus("Active");
                salesmanFacade.edit(account);
                request.getSession().setAttribute("successMessage", "Successfully approved a salesman.");
            } else if (action.equals("approveCustomer")) {
                //retrieve the user information from the database using JPA
                Customer customer = customerFacade.findByCustomerUsername(username);
                //retrieve the user information from the database
                customer.setStatus("Active");
                customerFacade.edit(customer);
                request.getSession().setAttribute("successMessage", "Successfully approved a customer.");
            } else if (action.equals("available")) {
                Long carId = Long.parseLong(request.getParameter("id"));
                Car car = carFacade.find(carId);
                //retrieve the user information from the database using JPA
                car.setStatus("Available");
                carFacade.edit(car);
            }

            //Retrieve list of users
            List<ManagingStaff> managingStaffList = managingStaffFacade.findAllManagingStaff();
            List<Customer> customerList = customerFacade.findAllCustomer();
            List<Salesman> salesmanList = salesmanFacade.findAllSalesman();
            List<Car> carList = carFacade.findAllCars();
            List<Transactions> transList = transactionsFacade.findAllTransactions();
            Long availableCount = carFacade.getAvailableCarCount();
            System.out.println("5" + availableCount);
            Long bookedCount = carFacade.getBookedCarCount();
            System.out.println("6" + bookedCount);
            Long paidCount = carFacade.getPaidCarCount();
            System.out.println("7" + paidCount);
            Long cancelledCount = carFacade.getCancelledCarCount();
            System.out.println("8" + cancelledCount);

            // Get gender count data from Customer and Salesman tables
            Long maleCount = customerFacade.findCustomerGenderCount("Male") + salesmanFacade.findSalesmanGenderCount("Male");
            Long femaleCount = customerFacade.findCustomerGenderCount("Female") + salesmanFacade.findSalesmanGenderCount("Female");
            // Create a list to hold the gender count data
            List<Long> genderCounts = new ArrayList<>();
            genderCounts.add(maleCount);
            genderCounts.add(femaleCount);
            System.out.println("9" + genderCounts);

            List<Feedback> feedbackList = feedbackFacade.findAll();
            int poorCount = 0;
            int neutralCount = 0;
            int goodCount = 0;
            for (Feedback feedback : feedbackList) {
                String rating = feedback.getRating();
                System.out.println("[Rating]" + rating);
                if (rating != null) {
                    switch (rating) {
                        case "1":
                        case "2":
                            poorCount++;
                            break;
                        case "3":
                            neutralCount++;
                            break;
                        case "4":
                        case "5":
                            goodCount++;
                            break;
                        default:
                            break;
                    }
                }
            }
            Long pendingTransCount = transactionsFacade.findTransactionsStatusCount("Pending");
            Long completedTransCount = transactionsFacade.findTransactionsStatusCount("Completed");
            Long cancelledTransCount = transactionsFacade.findTransactionsStatusCount("Cancelled");
//            System.out.println(completedTransCount);
            if (action.equals("staffsearch")) {
                // get the search keyword from the request parameter
                String searchKeyword = request.getParameter("searchKeyword");

                //Find user information by user type
                managingStaffList = managingStaffFacade.searchManagingStaff(searchKeyword);
                System.out.println("Search" + managingStaffList);
            } else if (action.equals("salesmansearch")) {
                // get the search keyword from the request parameter
                String searchKeyword = request.getParameter("searchKeyword");

                // Use the searchAccounts method with wild card search to retrieve the filtered account list
                salesmanList = salesmanFacade.searchSalesman(searchKeyword);

            } else if (action.equals("customersearch")) {
                // get the search keyword from the request parameter
                String searchKeyword = request.getParameter("searchKeyword1");

                // Use the searchAccounts method with wild card search to retrieve the filtered account list
                customerList = customerFacade.searchCustomer(searchKeyword);

            } else if (action.equals("carsearch")) {
                // get the search keyword from the request parameter
                String searchKeyword = request.getParameter("searchKeyword");

                // Use the searchAccounts method with wild card search to retrieve the filtered account list
                carList = carFacade.searchCar(searchKeyword);

            }
//            //set the list of users in the request attribute to be passed to the JSP
            request.setAttribute("managingStaffList", managingStaffList);
            request.setAttribute("customerList", customerList);
            request.setAttribute("salesmanList", salesmanList);
            request.setAttribute("carList", carList);
            request.setAttribute("transList", transList);
            request.setAttribute("customerCount", customerList.size());
            request.setAttribute("salespersonCount", salesmanList.size());
            request.setAttribute("availableCount", availableCount);
            request.setAttribute("bookedCount", bookedCount);
            request.setAttribute("paidCount", paidCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("genderCounts", genderCounts);
            request.setAttribute("poorCount", poorCount);
            request.setAttribute("neutralCount", neutralCount);
            request.setAttribute("goodCount", goodCount);
            request.setAttribute("pendingTransCount", pendingTransCount);
            request.setAttribute("completedTransCount", completedTransCount);
            request.setAttribute("cancelledTransCount", cancelledTransCount);
            // Redirect to the appropriate page
            request.getRequestDispatcher("managingstaffdashboard.jsp").forward(request, response);

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
