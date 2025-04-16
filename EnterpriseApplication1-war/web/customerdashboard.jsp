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
        <title>Customer Dashboard</title>
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
        <%
            Long id = Long.parseLong(request.getParameter("id"));
        %>
    </head>
    <body>
        <jsp:include page="/logoutmodal.jsp" />
        <!-- Navigation bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-dark">
            <h3 class="navbar-brand" style="color:white" >Car Sales System</h3>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:white" disabled data-toggle="tooltip" title="This is your username."><%= session.getAttribute("username")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#transSection" style="color:white" data-toggle="tooltip" title="Locate to Purchase History Section.">Purchase History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#feedbackSection" style="color:white" data-toggle="tooltip" title="Locate to Feedback Section.">Feedback</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-dismiss="modal" data-toggle="modal" data-target="#logoutModal" style="color:white">Logout</a>
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
                                    <a class="btn btn-primary" style="color:white" data-toggle="modal" data-target="#profileModal">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <!-- Available Cars Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Available Cars</h4>
                            <medium>Here are the available cars for sale.</medium>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered mt-3">
                                    <thead>
                                        <tr>
                                            <th>Make</th>
                                            <th>Model</th>
                                            <th>Chassis</th>
                                            <th>Year</th>
                                            <th>Color</th>
                                            <th>Price</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cars" items="${availableCarList}" varStatus="list">
                                            <tr>
                                                <td><c:out value="${cars.make}"/></td>
                                                <td><c:out value="${cars.model}"/></td>
                                                <td><c:out value="${cars.chassis}"/></td>
                                                <td><c:out value="${cars.caryear}"/></td>
                                                <td><c:out value="${cars.color}"/></td>
                                                <td><c:out value="${cars.price}"/></td>
                                                <td><c:out value="${cars.description}"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <!-- display "No data available" message if there is no feedback -->
                                <c:if test="${empty availableCarList}">
                                    <div class="text-center mt-3">No data available</div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!--Transaction Section-->
                    <section class="transSection" id="transSection">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="pending-tab" data-toggle="tab" href="#pending" role="tab" aria-controls="pending" aria-selected="true">Pending Transactions</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="history-tab" data-toggle="tab" href="#history" role="tab" aria-controls="history" aria-selected="false">Purchase History</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
                                <!-- Pending transaction section -->
                                <div class="card">
                                    <div class="card-body">
                                        <h2>Pending Transactions</h2>
                                        <p>View your pending transactions here:</p>
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Car Information</th>
                                                    <th>Car Chassis</th>
                                                    <th>Price</th>
                                                    <th>Salesman Name</th>
                                                    <th>Salesman Phone Number</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="trans" items="${showCustTransList}" varStatus="list">
                                                    <c:if test="${trans.transStatus eq 'Pending'}">
                                                        <tr>
                                                            <td>${trans.transDate}</td>
                                                            <td>${trans.car.make} | ${trans.car.model} | ${trans.car.caryear} | ${trans.car.color}</td>
                                                            <td>${trans.car.chassis}</td>
                                                            <td>${trans.car.price}</td>
                                                            <td>${trans.salesman.name}</td>
                                                            <td>${trans.salesman.hpnumber}</td>
                                                            <td>${trans.car.status}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <!-- display "No data available" message if there is no feedback -->
                                        <c:if test="${empty showCustTransList || not (showCustTransList.stream().anyMatch(trans -> trans.transStatus eq 'Pending'))}">
                                            <div class="text-center mt-3">No data available</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="history" role="tabpanel" aria-labelledby="history-tab">
                                <!-- Purchase history section -->
                                <div class="card">
                                    <div class="card-body">
                                        <h2>Purchase History</h2>
                                        <p>View your completed transactions here:</p>
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Car Information</th>
                                                    <th>Car Chassis</th>
                                                    <th>Price</th>
                                                    <th>Salesman Name</th>
                                                    <th>Salesman Phone Number</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="trans" items="${showCustTransList}" varStatus="list">
                                                    <c:if test="${trans.transStatus eq 'Completed'}">
                                                        <tr>
                                                            <td>${trans.transDate}</td>
                                                            <td>${trans.car.make} | ${trans.car.model} | ${trans.car.caryear} | ${trans.car.color}</td>
                                                            <td>${trans.car.chassis}</td>
                                                            <td>${trans.car.price}</td>
                                                            <td>${trans.salesman.name}</td>
                                                            <td>${trans.salesman.hpnumber}</td>
                                                            <td>${trans.car.status}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <!-- display "No data available" message if there is no feedback -->
                                        <c:if test="${empty showCustTransList || not (showCustTransList.stream().anyMatch(trans -> trans.transStatus eq 'Completed'))}">
                                            <div class="text-center mt-3">No data available</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section><br>
                    <!-- Feedback Section -->
                    <section class="feedbackSection" id="feedbackSection">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h4>Feedback</h4>
                                <medium>Share your feedback about our cars and services.</medium>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered mt-3">
                                        <thead>
                                            <tr>
                                                <th>Car Information</th>
                                                <th>Chassis Number</th>
                                                <th>Price</th>
                                                <th>Salesman</th>
                                                <th>Payment Status</th>
                                                <th>Feedback & Rating</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- loop through feedback items -->

                                            <c:forEach var="trans" items="${showCustTransList}" varStatus="list">
                                                <c:if test="${trans.transStatus eq 'Completed'}">
                                                    <tr>
                                                        <td>${trans.car.make} | ${trans.car.model} | ${trans.car.caryear} | ${trans.car.color}</td>
                                                        <td>${trans.car.chassis}</td>
                                                        <td>${trans.car.price}</td>
                                                        <td>${trans.salesman.name}</td>
                                                        <td>${trans.transStatus}</td>
                                                        <td>${trans.feedback.feedback != null ? trans.feedback.feedback : "No Feedback Yet"} | ${trans.feedback.rating != null ? trans.feedback.rating : "No Rating Yet"}</td>
                                                        <td>
                                                            <button class="btn btn-primary btn-sm"
                                                                    ${trans.feedback.feedback != null && trans.feedback.rating != null ? ' disabled' : ''}
                                                                    data-toggle="tooltip"
                                                                    data-placement="top"
                                                                    title="${trans.feedback.feedback != null && trans.feedback.rating != null ? 'You have already given the feedback!' : 'Give Feedback'}"
                                                                    onclick="$('#feedbackModal${list.index}').modal('show');" type="button">
                                                                Give Feedback
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                        </td>
                                                        <!-- Feedback Modal -->
                                                <div class="modal fade" id="feedbackModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="feedbackModalLabel">Leave Feedback</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form method="POST" action="${pageContext.request.contextPath}/CustomerDashboardFunction?action=feedback&id=<%=id%>&feedbackId=${trans.feedback.id}">
                                                                    <div class="form-group">
                                                                        <label for="feedback-comment" class="col-form-label">Feedback Comment:</label>
                                                                        <textarea class="form-control" id="feedback-comment" name="feedback" required></textarea>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="feedback-rating" class="col-form-label">Rating:</label>
                                                                        <select class="form-control" id="feedback-rating" name="rating">
                                                                            <option value="1">1</option>
                                                                            <option value="2">2</option>
                                                                            <option value="3">3</option>
                                                                            <option value="4">4</option>
                                                                            <option value="5">5</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                                    </div>
                                                                </form>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- display "No data available" message if there is no feedback -->
                                    <c:if test="${empty showCustTransList}">
                                        <div class="text-center mt-3">No data available</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </section>
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
