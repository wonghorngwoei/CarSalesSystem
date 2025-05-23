<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Car Sales System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Link to Font Awesome icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
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
        <script>
            function togglePassword() {
                var password = document.getElementById("password");
                if (password.type === "password") {
                    password.type = "text";
                } else {
                    password.type = "password";
                }
            }
        </script>
        <!-- Include Message Handling -->
        <jsp:include page="/messagehandling.jsp" />

    </head>
    <body>
        <!-- Navigation bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-dark">
            <h2 class="navbar-brand" style="color:white" >Car Sales System</h2>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link"  href="#" data-toggle="modal" style="color:white" data-target="#loginModal">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  style="color:white" href="#about-us">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  style="color:white" href="#contact-us">Contact Us</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Login Modal -->
        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Login</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="Login" method="POST">
                            <div class="form-group">
                                <label for="text">Username</label>
                                <input type="text" class="form-control" id="username" name="x" placeholder="Enter Username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="y" placeholder="Enter Password" required>
                                    <span class="input-group-append">
                                        <span class="input-group-text">
                                            <input type="checkbox" onclick="togglePassword()"> Show
                                        </span>
                                    </span>
                                </div>
                            </div>
                            <p><input type="submit" class="btn btn-primary" value="Login"></p>
                            <br>
                            <p>Don't have an account? <a href="#" data-dismiss="modal" data-toggle="modal" data-target="#registrationModal">Register</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Registration Modal -->
        <div class="modal fade" id="registrationModal" tabindex="-1" role="dialog" aria-labelledby="registrationModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registrationModalLabel">Create an Account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="Register" method="POST">
                            <div class="form-group">
                                <label for="id">Username</label>
                                <input type="text" class="form-control" id="id" name="x1" placeholder="Enter Username" required >
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="x2" placeholder="Enter Password" required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d\s:])([^\s]){8,}$">
                                <small>Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 numeric number, and 1 special character.</small>
                            </div>
                            <div class="form-group">
                                <label for="email">Email address</label>
                                <input type="email" class="form-control" id="email" name="x3" aria-describedby="emailHelp" placeholder="Enter email" required>
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" class="form-control" id="name" name="x4" placeholder="Enter Full Name" required>
                            </div>
                            <div class="form-group">
                                <label for="age">Age</label>
                                <input type="number" class="form-control" id="age" name="x5" placeholder="Enter Age" required>
                            </div>
                            <div class="form-group">
                                <label for="hpnumber">Phone Number</label>
                                <input type="number" class="form-control" id="hpnumber" name="x6" placeholder="Enter phone number" required>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender: </label>
                                <select id="gender" name="x7" required>
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="userType">User Type: </label>
                                <select id="userType" name="x8" required>
                                    <option value="" disabled selected>Select user type</option>
                                    <option value="salesman">Salesman</option>
                                    <option value="customer">Customer</option>
                                </select>
                            </div>
                            <p><input type="submit" class="btn btn-primary" value="Register"></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Background image section -->
        <section class="hero-image">
            <div class="hero-text">
                <h1>Welcome to Car Sales System</h1>
                <b><h3>Find your dream car today</h3></b>
                <i><p>We offer a wide selection of high-quality cars at affordable prices.</p></i>
            </div>
        </section>

        <!-- About us section -->
        <section class="about-us" id="about-us">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2>About us</h2>
                        <hr>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <p>Welcome to our web-based car sales system.</p>
                        <p>We are dedicated to providing you with the best online car buying experience possible. Our system is designed to be easy to use and convenient for car shoppers of all kinds.</p>
                        <p>Our system offers a wide range of features that cater to the needs of both car buyers and sellers. We believe that buying and selling cars should be a hassle-free experience and that's why we have designed our platform to be easy to use and accessible to everyone.</p>
                        <p>Our team is dedicated to providing excellent customer service, ensuring that every customer's experience is a positive one. We are always striving to improve and evolve our system to better meet the needs of our users.</p>
                        <p>We value transparency, honesty and fairness in all our dealings. We believe that every car buyer and seller deserves to have access to accurate and reliable information to make informed decisions.</p>
                        <p>Thank you for choosing our web-based car sales system. We look forward to helping you find your dream car!</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact us section -->
        <section class="contact-section" id="contact-us" style="background-color: #f2f2f2;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center">
                        <h2 class="section-heading mb-4">Contact Us</h2>
                        <p class="mb-5">We are always ready to hear from you. Whether you have a question about our services, need assistance or just want to say hello, we'd love to hear from you!</p>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-4 text-center">
                        <p class="card-text"><i class="fas fa-map-marker-alt"></i> 123, Jalan Wong,<br>Kuala Lumpur,<br>Malaysia</p>
                    </div>
                    <div class="col-lg-4 text-center">
                        <p class="card-text"><i class="fas fa-phone"></i> +603-16882828</p>
                    </div>
                    <div class="col-lg-4 text-center">
                        <p class="card-text"><i class="fas fa-envelope"></i> info@carsales.com</p>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>


