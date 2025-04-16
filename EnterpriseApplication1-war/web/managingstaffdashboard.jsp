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
        <title>Managing Staff Dashboard</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <a class="nav-link" href="#" style="color:white" data-toggle="modal" data-target="#transactionRecordModal">Transactions Report</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#tables" style="color:white">Tables</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-dismiss="modal" data-toggle="modal" data-target="#logoutModal" style="color:white">Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- Main content -->
        <div class="container-fluid mt-3">

            <!-- Report Section -->
            <div class="container mt-5 custom-class">
                <h3 class="mt-3">Report & Analysis</h3>
                <hr>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Payment Report
                            </div>
                            <div class="card-body">
                                <canvas id="transactionChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Gender Report
                            </div>
                            <div class="card-body">
                                <canvas id="genderChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Customer & Salesman Report
                            </div>
                            <div class="card-body">
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Inventory Report
                            </div>
                            <div class="card-body">
                                <canvas id="inventoryChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Feedback Report
                            </div>
                            <div class="card-body">
                                <canvas id="feedbackChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            </div>

            <section class ="tables" id="tables">
                <div class="container mt-5 mb-5 custom-class">
                    <!--Managing staff information section-->
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link" id="staff-tab" data-toggle="tab" href="#staff" role="tab" aria-controls="staff" aria-selected="true">Managing Staff</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="salesman-tab" data-toggle="tab" href="#salesman" role="tab" aria-controls="salesman" aria-selected="false">Salesman</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="customer-tab" data-toggle="tab" href="#customer" role="tab" aria-controls="customer" aria-selected="false">Customer</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="car-tab" data-toggle="tab" href="#car" role="tab" aria-controls="car" aria-selected="false">Car</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="staff" role="tabpanel" aria-labelledby="staff-tab">
                            <!-- Managing Staff Section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Managing Staff Table</h2>
                                    <p>Manage your staff here:</p>
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addStaffModal">Add Staff</button><br><br>
                                    <!-- Search bar -->
                                    <form>
                                        <div class="row">
                                            <div class="input-group mb-3">
                                                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="Search by Username, Name, Email, Phone" aria-label="Search by Username, Name, Email, Phone" aria-describedby="basic-addon2">
                                                <input type ="hidden" value ="staffsearch" name="action">
                                                <div class="input-group-append">
                                                    <button id="searchButton" class="btn btn-outline-secondary">Search</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Staff ID</th>
                                                <th>Staff Username</th>
                                                <th>Staff Password</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="staff" items="${managingStaffList}" varStatus="list">
                                                <tr>
                                                    <td>${staff.id}</td>
                                                    <td>${staff.username}</td>
                                                    <td>${staff.password}</td>
                                                    <td>${staff.name}</td>
                                                    <td>${staff.email}</td>
                                                    <td>${staff.hpnumber}</td>
                                                    <td>
                                                        <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editStaffModal${list.index}">Edit</a>
                                                        <c:if test="${staff.id ne sessionScope.id}">
                                                            <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=deleteStaff&username=${staff.username}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this account? This cannot be undone.')">Delete<i class="fa fa-trash"></i></a>
                                                            </c:if>

                                                        <c:if test="${staff.id eq sessionScope.id}">
                                                            <button class="btn btn-sm btn-danger" disabled="true" data-toggle="tooltip" title="Cannot delete own account">Delete<i class="fa fa-trash"></i></button>
                                                            </c:if>
                                                    </td>
                                                </tr>
                                                <!--Edit Staff Modal-->
                                            <div class="modal fade" id="editStaffModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="editStaffModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="editStaffModalLabel">Edit Staff</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=editStaff" method="POST">
                                                                <div class="form-group">
                                                                    <label for="username">Username</label>
                                                                    <input type="text" class="form-control" id="username" name="username" value="${staff.username}" readonly>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="password">Password</label>
                                                                    <input type="text" class="form-control" id="password" name="password" value="${staff.password}" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d\s:])([^\s]){8,}$">
                                                                    <small>Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 numeric number, and 1 special character.</small>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="email">Email address</label>
                                                                    <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" value="${staff.email}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="name">Full Name</label>
                                                                    <input type="text" class="form-control" id="name" name="name" value="${staff.name}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="hpnumber">Phone Number</label>
                                                                    <input type="text" class="form-control" id="hpnumber" name="hpnumber" value="${staff.hpnumber}" required>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary" value="">Save Changes</button>
                                                                </div>
                                                            </form>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="salesman" role="tabpanel" aria-labelledby="salesman-tab">
                            <!-- Salesman section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Salesman Table</h2>
                                    <p>Manage salesman here:</p>
                                    <form>
                                        <div class="input-group mb-3">
                                            <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="Search by ID, Name, Email, Gender, Hpnumber, or Status" aria-label="Search by ID, Name, Email, Gender, Hpnumber, or Status" aria-describedby="basic-addon2">
                                            <input type ="hidden" value ="salesmansearch" name="action">
                                            <div class="input-group-append">
                                                <button id="searchButton" class="btn btn-outline-secondary">Search</button>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Password</th>
                                                <th>Name</th>
                                                <th>Age</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Gender</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="salesman" items="${salesmanList}" varStatus="list">
                                                <tr>
                                                    <td>${salesman.id}</td>
                                                    <td>${salesman.username}</td>
                                                    <td>${salesman.password}</td>
                                                    <td>${salesman.name}</td>
                                                    <td>${salesman.age}</td>
                                                    <td>${salesman.email}</td>
                                                    <td>${salesman.hpnumber}</td>
                                                    <td>${salesman.gender}</td>
                                                    <td>${salesman.status}</td>
                                                    <c:if test="${not empty salesmanList}">
                                                        <td>
                                                            <c:if test="${salesman.status == 'Pending'}">
                                                                <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=approveSalesman&username=${salesman.username}" class="btn btn-sm btn-success">Approve</a>
                                                            </c:if>
                                                            <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editSalesmanModal${list.index}">Edit<i class="fa fa-edit"></i></a>
                                                                <c:set var="disabled" value="false"/>
                                                                <c:forEach var="trans" items="${transList}">
                                                                    <c:if test="${salesman.id == trans.salesman.id}">
                                                                        <c:set var="disabled" value="true"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:choose>
                                                                    <c:when test="${disabled == 'true'}">
                                                                    <button href="#" class="btn btn-sm btn-danger" title="This salesman is tied to a transaction, it cannot be deleted." disabled>Delete</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=deleteSalesman&username=${salesman.username}" onclick="return confirm('Are you sure you want to delete this account? This cannot be undone.')" class="btn btn-sm btn-danger">Delete<i class="fa fa-trash"></i></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                                <!--Edit profile modal-->
                                            <div class="modal fade" id="editSalesmanModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="editSalesmanModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="editSalesmanModalLabel">Edit Profile</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=editSalesman" method="POST">
                                                                <div class="form-group">
                                                                    <label for="username">Username</label>
                                                                    <input type="text" class="form-control" id="username" name="username" value="${salesman.username}" readonly>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="password">Password</label>
                                                                    <input type="text" class="form-control" id="password" name="password" value="${salesman.password}" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d\s:])([^\s]){8,}$">
                                                                    <small>Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 numeric number, and 1 special character.</small>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="email">Email address</label>
                                                                    <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" value="${salesman.email}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="name">Full Name</label>
                                                                    <input type="text" class="form-control" id="name" name="name" value="${salesman.name}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="age">Age</label>
                                                                    <input type="number" class="form-control" id="age" name="age" value="${salesman.age}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="hpnumber">Phone Number</label>
                                                                    <input type="text" class="form-control" id="hpnumber" name="hpnumber" value="${salesman.hpnumber}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="gender">Gender: </label>
                                                                    <select id="gender" name="gender" required>
                                                                        <option class="form-control" disabled selected>Select gender</option>
                                                                        <option value="Male" <c:if test="${salesman.gender eq 'Male'}">selected</c:if>>Male</option>
                                                                        <option value="Female" <c:if test="${salesman.gender eq 'Female'}">selected</c:if>>Female</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="submit" class="btn btn-primary" value="">Save Changes</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="customer" role="tabpanel" aria-labelledby="customer-tab">
                            <!-- Customer section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Customer Table</h2>
                                    <p>Manage customer here:</p>
                                    <form>
                                        <div class="input-group mb-3">
                                            <input type="text" id="searchKeyword" name="searchKeyword1" class="form-control" placeholder="Search by ID, Name, Email, Gender, Hpnumber" aria-label="Search by ID, Name, Email, Gender, Hpnumber" aria-describedby="basic-addon2">
                                            <input type ="hidden" value ="customersearch" name="action">
                                            <div class="input-group-append">
                                                <button id="searchButton" class="btn btn-outline-secondary">Search</button>
                                            </div>
                                        </div>
                                    </form>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Password</th>
                                                <th>Name</th>
                                                <th>Age</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Gender</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cust" items="${customerList}" varStatus="list">
                                                <tr>
                                                    <td>${cust.id}</td>
                                                    <td>${cust.username}</td>
                                                    <td>${cust.password}</td>
                                                    <td>${cust.name}</td>
                                                    <td>${cust.age}</td>
                                                    <td>${cust.email}</td>
                                                    <td>${cust.hpnumber}</td>
                                                    <td>${cust.gender}</td>
                                                    <td>${cust.status}</td>
                                                    <c:if test="${not empty customerList}">
                                                        <td>
                                                            <c:if test="${cust.status == 'Pending'}">
                                                                <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=approveCustomer&username=${cust.username}" class="btn btn-sm btn-success">Approve</a>
                                                            </c:if>
                                                            <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editCustModal${list.index}">Edit<i class="fa fa-edit"></i></a>
                                                                <c:set var="disabled" value="false"/>
                                                                <c:forEach var="trans" items="${transList}">
                                                                    <c:if test="${cust.id == trans.customer.id}">
                                                                        <c:set var="disabled" value="true"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:choose>
                                                                    <c:when test="${disabled == 'true'}">
                                                                    <button href="#" class="btn btn-sm btn-danger" title="This customer is tied to a transaction, it cannot be deleted." disabled>Delete</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=deleteSalesman&username=${cust.username}" onclick="return confirm('Are you sure you want to delete this account? This cannot be undone.')" class="btn btn-sm btn-danger">Delete<i class="fa fa-trash"></i></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                                <!--Edit profile modal-->
                                            <div class="modal fade" id="editCustModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="editCustModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="editCustModalLabel">Edit Profile</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=editCustomer" method="POST">
                                                                <div class="form-group">
                                                                    <label for="username">Username</label>
                                                                    <input type="text" class="form-control" id="username" name="username" value="${cust.username}" readonly>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="password">Password</label>
                                                                    <input type="text" class="form-control" id="password" name="password" value="${cust.password}" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d\s:])([^\s]){8,}$">
                                                                    <small>Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 numeric number, and 1 special character.</small>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="email">Email address</label>
                                                                    <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" value="${cust.email}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="name">Full Name</label>
                                                                    <input type="text" class="form-control" id="name" name="name" value="${cust.name}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="age">Age</label>
                                                                    <input type="number" class="form-control" id="age" name="age" value="${cust.age}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="hpnumber">Phone Number</label>
                                                                    <input type="text" class="form-control" id="hpnumber" name="hpnumber" value="${cust.hpnumber}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="gender">Gender: </label>
                                                                    <select id="gender" name="gender" required>
                                                                        <option class="form-control" disabled selected>Select gender</option>
                                                                        <option value="Male" <c:if test="${cust.gender eq 'Male'}">selected</c:if>>Male</option>
                                                                        <option value="Female" <c:if test="${cust.gender eq 'Female'}">selected</c:if>>Female</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="submit" class="btn btn-primary" value="">Save Changes</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="car" role="tabpanel" aria-labelledby="car-tab">
                            <!-- Car section -->
                            <div class="card">
                                <div class="card-body">
                                    <h2>Car Table</h2>
                                    <p>Manage car here:</p>
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addCarModal">Add Cars</button> <br><br>
                                    <!-- Search bar -->
                                    <form onsubmit="handleSearch(event)">
                                        <div class="row">
                                            <div class="input-group mb-3">
                                                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="Search by Make, Model, Chassis, Year, Color, Price, Description, Status" aria-label="Search by Username, Name, Email, Phone" aria-describedby="basic-addon2">
                                                <input type ="hidden" value ="carsearch" name="action">
                                                <div class="input-group-append">
                                                    <button id="searchButton" class="btn btn-outline-secondary">Search</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
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
                                                <th>Set Car Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cars" items="${carList}" varStatus="list">
                                                <tr>
                                                    <td>${cars.make}</td>
                                                    <td>${cars.model}</td>
                                                    <td>${cars.chassis}</td>
                                                    <td>${cars.caryear}</td>
                                                    <td>${cars.color}</td>
                                                    <td>${cars.price}</td>
                                                    <td>${cars.description}</td>
                                                    <td>${cars.status}</td>
                                                    <td>
                                                        <c:if test="${cars.status eq 'Cancelled'}">
                                                            <a href="${pageContext.request.contextPath}/ManagingStaffFunction?action=available&id=${cars.id}" class="btn btn-success btn-sm">Available <i class="fa fa-edit"></i></a>
                                                            </c:if>
                                                            <c:if test="${cars.status ne 'Cancelled'}">
                                                            <button class="btn btn-success btn-sm" onclick="showAlert()">Available <i class="fa fa-edit"></i></button>
                                                            </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${cars.status eq 'Available'}">
                                                            <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#carModal${list.index}">Edit<i class="fa fa-edit"></i></a>
                                                            </c:if>
                                                            <c:if test="${cars.status ne 'Available'}">
                                                            <button class="btn btn-primary btn-sm" disabled data-toggle="tooltip" data-placement="top" title="This car is not available for editing,only can delete when status is 'Available'">Edit</button>
                                                        </c:if>
                                                        <c:if test="${cars.status eq 'Available'}">
                                                            <a href="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=deleteCar&id=${car.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this car details? This cannot be undone.')">Delete<i class="fa fa-trash"></i></a>
                                                            </c:if>
                                                            <c:if test="${cars.status ne 'Available'}">
                                                            <button class="btn btn-danger btn-sm" disabled data-toggle="tooltip" data-placement="top" title="This car is not available for deletion, only can delete when status is 'Available'">Delete</button>
                                                        </c:if>

                                                    </td>
                                                </tr>
                                                <!--Edit car modal-->
                                            <div class="modal fade" id="carModal${list.index}" tabindex="-1" role="dialog" aria-labelledby="carModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="carModalLabel">Edit Profile</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="${pageContext.request.contextPath}/ManagingStaffDashboardFunction?action=editCar" method="POST">
                                                                <div class="form-group">
                                                                    <label for="make">Make</label>
                                                                    <input type="text" class="form-control" id="make" name="carmake" value="${cars.make}" required>
                                                                    <input type ="hidden" id="carId" name="carId" value="${cars.id}">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="model">Model</label>
                                                                    <input type="text" class="form-control" id="model" name="carmodel" value="${cars.model}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="chassis">Chassis Number</label>
                                                                    <input type="text" class="form-control" id="chassis" name="carchassis" aria-describedby="emailHelp" value="${cars.chassis}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="caryear">Car Year</label>
                                                                    <input type="number" class="form-control" id="caryear" name="caryear" value="${cars.caryear}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="color">Color</label>
                                                                    <input type="text" class="form-control" id="color" name="carcolor" value="${cars.color}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="price">Price</label>
                                                                    <input type="number" step="any" class="form-control" id="price" name="carprice" value="${cars.price}" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="desc">Description</label>
                                                                    <input type="text" class="form-control" id="desc" name="cardesc" value="${cars.description}" required>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary" value="">Save Changes</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>



            <!-- Add Staff Modal -->
            <div class="modal fade" id="addStaffModal" tabindex="-1" role="dialog" aria-labelledby="addStaffModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addStaffModalLabel">Add Staff</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="AddStaff" method="POST">
                                <div class="form-group">
                                    <label for="id">Username</label>
                                    <input type="text" class="form-control" id="id" name="x11" placeholder="Enter Username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="x12" placeholder="Enter Password" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d\s:])([^\s]){8,}$">
                                    <small>Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 numeric number, and 1 special character.</small>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" id="email" name="x13" aria-describedby="emailHelp" placeholder="Enter email" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="x14" placeholder="Enter Full Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="hpnumber">Phone Number</label>
                                    <input type="text" class="form-control" id="hpnumber" name="x15" placeholder="Enter phone number" required>
                                </div>
                                <p><input type="submit" class="btn btn-primary" value="Add"></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Add Car Modal -->
            <div class="modal fade" id="addCarModal" tabindex="-1" role="dialog" aria-labelledby="addCarModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addCarModalLabel">Add Cars</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="AddCar" method="POST">
                                <div class="form-group">
                                    <label for="make">Make</label>
                                    <input type="text" class="form-control" id="carmake" name="carmake" placeholder="Enter car brand" required>
                                </div>
                                <div class="form-group">
                                    <label for="model">Model</label>
                                    <input type="text" class="form-control" id="carmodel" name="carmodel" placeholder="Enter car model" required>
                                </div>
                                <div class="form-group">
                                    <label for="model">Chassis Number</label>
                                    <input type="text" class="form-control" id="carchassis" name="carchassis" placeholder="Enter car chassis number" required>
                                </div>
                                <div class="form-group">
                                    <label for="year">Year</label>
                                    <input type="number" class="form-control" id="caryear" name="caryear" placeholder="Enter car manufacture year" required>
                                </div>
                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" class="form-control" id="carcolor" name="carcolor" placeholder="Enter car color" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="text" class="form-control" id="carprice" name="carprice" placeholder="Enter price" required>
                                </div>
                                <div class="form-group">
                                    <label for="desc">Description</label>
                                    <input type="text" class="form-control" id="cardesc" name="cardesc" placeholder="Enter description of the car" required>
                                </div>
                                <p><input type="submit" class="btn btn-primary" value="Add"></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sales Record Modal -->
            <div class="modal fade" id="transactionRecordModal" tabindex="-1" role="dialog" aria-labelledby="transactionRecordModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="transactionRecordModalLabel">Sales Record</h5>
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
                                        <th>Salesman Name</th>
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
                                            <td>${trans.salesman.name}</td>
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
        </div>

        <!-- JavaScript for Charts -->
        <jsp:include page="/chart.jsp" />
    </div>
</body>
</html>
