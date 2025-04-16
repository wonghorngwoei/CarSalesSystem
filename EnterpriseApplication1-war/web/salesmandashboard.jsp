<!--JSTL-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--Prevent cache-->
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setHeader("Expires", "0");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salesman Dashboard</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Google supported fonts -->
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
        <!-- Cascading Style Sheet -->
        <link rel="stylesheet" type="text/css" href="style.css">
        <!-- Include Message Handling -->
        <jsp:include page="/messagehandling.jsp" />
    </head>
    <body>
        <jsp:include page="/logoutmodal.jsp" />
        <!-- Navigation bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-dark">
            <h3 class="navbar-brand" style="color:white">Car Sales System</h3>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:white" disabled data-toggle="tooltip" title="This is your username."><%= session.getAttribute("username")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="modal" style="color:white" data-target="#salesRecordModal">Sales Records</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-dismiss="modal" data-toggle="modal" data-target="#logoutModal" style="color:white" style="color:white">Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <br>
        <br>
        <!-- User profile section -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">User Profile</h5>
                            <hr>
                            <div class="row">
                                <div class="col-md-7">
                                    <p><strong>Name:</strong><%= request.getAttribute("name")%></p>
                                    <p><strong>Age:</strong> <%= request.getAttribute("age")%></p>
                                    <p><strong>Email:</strong><%= request.getAttribute("email")%></p>
                                    <p><strong>Phone:</strong><%= request.getAttribute("hpnumber")%></p>
                                    <p><strong>Gender:</strong><%= request.getAttribute("gender")%></p>
                                    <a class="btn btn-primary" style="color: white;" data-toggle="modal" data-target="#profileModal">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <!-- Cars Table -->
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="pending-tab" data-toggle="tab" href="#pending" role="tab" aria-controls="pending" aria-selected="true">Available Cars</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="history-tab" data-toggle="tab" href="#history" role="tab" aria-controls="history" aria-selected="false">Sales</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
                            <!-- Available car section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Available Cars</h2>
                                    <p>Book the car for your customer here:</p>
                                    <div class="text-right mb-3">
                                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#setAvailableModal">Set Car Available</button>
                                    </div>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Make</th>
                                                <th>Model</th>
                                                <th>Chassis</th>
                                                <th>Year</th>
                                                <th>Color</th>
                                                <th>Price</th>
                                                <th>Description</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cars" items="${carList}" varStatus="list">
                                                <c:if test="${cars.status eq 'Available'}">
                                                    <tr>
                                                        <td>${cars.make}</td>
                                                        <td>${cars.model}</td>
                                                        <td>${cars.chassis}</td>
                                                        <td>${cars.caryear}</td>
                                                        <td>${cars.color}</td>
                                                        <td>${cars.price}</td>
                                                        <td>${cars.description}</td>
                                                        <td>
                                                            <a href="#" class="btn btn-primary btn-sm"data-toggle="modal" data-target="#salesModal${list.index}" >Book <i class="fa fa-edit"></i></a>
                                                        </td>
                                                    </tr>
                                                    <!-- Sales Modal -->
                                                <div class="modal fade" id="salesModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="salesModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="salesModalLabel">Make Payment</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form method="POST" action="${pageContext.request.contextPath}/SalesmanDashboardFunction?action=sales">
                                                                    <div class="form-group">
                                                                        <label for="customerName">Customer Name:</label>
                                                                        <select class="form-control" id="customerName" name="customerId" required>
                                                                            <option value="">Select a customer</option>
                                                                            <c:forEach var="customer" items="${custList}">
                                                                                <option value="${customer.id}">${customer.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="car">Car Selected:</label>
                                                                        <input type="text" class="form-control" id="selectedCar" name="selectedCar" value="${cars.model}" readonly>
                                                                        <input type="hidden" value ="${cars.id}" name="carId">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="car">Car Chassis:</label>
                                                                        <input type="text" class="form-control" id="carChassis" name="carChassis" value="${cars.chassis}" readonly>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="comments">Comments:</label>
                                                                        <input type="textarea" class="form-control" id="comments" name="comments" required>
                                                                    </div>
                                                                    <button type="submit" class="btn btn-primary">Submit Booking</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- display "No data available" message if there is no available car -->
                                    <c:if test="${not (carList.stream().anyMatch(cars -> cars.status eq 'Available'))}">
                                        <div class="text-center mt-3">No data available</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="history" role="tabpanel" aria-labelledby="history-tab">
                            <!-- Car Sales section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Car Sales</h2>
                                    <p>View your Sales here:</p>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Make</th>
                                                <th>Model</th>
                                                <th>Chassis</th>
                                                <th>Year</th>
                                                <th>Color</th>
                                                <th>Price</th>
                                                <th>Description</th>
                                                <th>Status</th>
                                                <th>Actions(Set Status)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="trans" items="${transList}" varStatus="list">
                                                <c:if test="${trans.transStatus eq 'Pending' && trans.car.status eq 'Booked' or trans.car.status eq 'Paid' && trans.transStatus eq 'Completed' or trans.car.status eq 'Cancelled'}">
                                                    <tr>
                                                        <td>${trans.car.make}</td>
                                                        <td>${trans.car.model}</td>
                                                        <td>${trans.car.chassis}</td>
                                                        <td>${trans.car.caryear}</td>
                                                        <td>${trans.car.color}</td>
                                                        <td>${trans.car.price}</td>
                                                        <td>${trans.car.description}</td>
                                                        <td>${trans.car.status}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${trans.car.status eq 'Booked'}">
                                                                    <a href="${pageContext.request.contextPath}/SalesmanDashboardFunction?action=pay&transId=${trans.id}&carId=${trans.car.id}" class="btn btn-secondary btn-sm" >Pay <i class="fa fa-edit"></i></a>
                                                                    <a href="${pageContext.request.contextPath}/SalesmanDashboardFunction?action=cancel&transId=${trans.id}&carId=${trans.car.id}" class="btn btn-danger btn-sm" >Delete <i class="fa fa-trash"></i></a>
                                                                    </c:when>
                                                                    <c:when test="${trans.car.status eq 'Paid'}">
                                                                    <p>No action needed</p>
                                                                </c:when>
                                                                <c:when test="${trans.car.status eq 'Cancelled'}">
                                                                    <p>No action needed</p>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- display "No data available" message if there is no feedback -->
                                    <c:if test="${empty transList || not (transList.stream().anyMatch(trans -> trans.car.status eq 'Booked' || trans.car.status eq 'Paid' || trans.car.status eq 'Cancelled'))}">
                                        <div class="text-center mt-3">No data available</div>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Set car to available Modal -->
            <div class="modal fade" id="setAvailableModal" tabindex="-1" role="dialog" aria-labelledby="setAvailableModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="setAvailableModalLabel">Set Car to Available Status</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form method="POST" action="${pageContext.request.contextPath}/SalesmanDashboardFunction?action=available">
                                <div class="form-group">
                                    <label for="carId">Car to set available:</label>
                                    <select class="form-control" id="carId" name="carId" required>
                                        <option value="">Select a Car</option>
                                        <c:forEach var="car" items="${cancelledCarList}">
                                            <option value="${car.id}">${car.make}|${car.model}|${car.caryear}|${car.chassis}|${car.color}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary" ${empty cancelledCarList ? 'disabled' : ''} data-toggle="tooltip" data-placement="bottom" title="${empty cancelledCarList ? 'There are no cancelled cars to set available' : ''}">Set Status Available</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sales Record Modal -->
            <div class="modal fade" id="salesRecordModal" tabindex="-1" role="dialog" aria-labelledby="salesRecordModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="salesRecordModalLabel">Individual Sales Record</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Transaction ID</th>
                                        <th>Transaction Date</th>
                                        <th>Car Information</th>
                                        <th>Car Chassis Number</th>
                                        <th>Price</th>
                                        <th>Customer Feedback & Rating</th>
                                        <th>Customer Name</th>
                                        <th>Comment</th>
                                        <th>Transaction Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="trans" items="${transList}" varStatus="list">
                                        <tr>
                                            <td>${trans.id}</td>
                                            <td>${trans.transDate}</td>
                                            <td>${trans.car.make} | ${trans.car.model} | ${trans.car.caryear} | ${trans.car.color}</td>
                                            <td>${trans.car.chassis}</td>
                                            <td>${trans.car.price}</td>
                                            <td>${trans.feedback.feedback != null ? trans.feedback.feedback : "No Feedback Yet"} | ${trans.feedback.rating != null ? trans.feedback.rating : "No Rating Yet"}</td>
                                            <td>${trans.customer.name}</td>
                                            <td>${trans.comment}</td>
                                            <td>${trans.transStatus}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit profile modal -->
            <div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="profileModalLabel">Edit Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="input-group">
                                    <div class="form-group" style="margin:10px;">
                                        <label for="name">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%= request.getAttribute("name")%>" required>
                                    </div>
                                    <div class="form-group" style="margin:10px;">
                                        <label for="age">Age</label>
                                        <input type="number" class="form-control" id="age" name="age" value="<%= (request.getAttribute("age"))%>" required>
                                    </div>
                                    <div class="form-group" style="margin:10px;">
                                        <label for="email">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email")%>" required>
                                    </div>
                                    <div class="form-group" style="margin:10px;">
                                        <label for="hpnumber">Phone</label>
                                        <input type="text" class="form-control" id="hpnumber" name="hpnumber" value="<%= request.getAttribute("hpnumber")%>" required>
                                    </div>
                                    <div class="form-group" style="margin:10px;">
                                        <label for="gender">Gender</label>
                                        <select class="form-control " name ="gender" id="gender" required>
                                            <option value="Male" <%= request.getAttribute("gender").equals("Male") ? "selected" : ""%>>Male</option>
                                            <option value="Female" <%= request.getAttribute("gender").equals("Female") ? "selected" : ""%>>Female</option>
                                        </select>
                                    </div>
                                    <input type ="hidden" value ="edit" name="action">
                                </div>
                                <div class="input-group-append modal-footer">
                                    <button type="submit" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button class="btn btn-primary" >Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
