<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register for an Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("email").focus();
            loadFormData();
        });

        function validateForm() {
            let email = document.getElementById("email").value;
            let phone = document.getElementById("phone").value;
            let country = document.getElementById("country").value;
            let terms = document.getElementById("terms").checked;
            let errorMessages = document.getElementById("errorMessages");

            errorMessages.innerHTML = "";
            let errors = [];

            if (email.trim() === "") errors.push("Please enter an email address.");
            else if (!email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) 
                errors.push("Invalid email format (ex: email@gmail.com).");

            if (phone.trim() === "") errors.push("Please enter a mobile phone number.");
            if (country === "") errors.push("Please select a country.");
            if (!terms) errors.push("You must agree to the terms of service.");

            if (errors.length > 0) {
                errorMessages.innerHTML = "<ul><li>" + errors.join("</li><li>") + "</li></ul>";
                errorMessages.style.display = "block";
                return false;
            }
            
            saveFormData();
            return true;
        }

        function saveFormData() {
            document.cookie = "email=" + document.getElementById("email").value;
            document.cookie = "phone=" + document.getElementById("phone").value;
            document.cookie = "country=" + document.getElementById("country").value;
        }

        function loadFormData() {
            let cookies = document.cookie.split("; ");
            cookies.forEach(cookie => {
                let [name, value] = cookie.split("=");
                if (document.getElementById(name)) {
                    document.getElementById(name).value = decodeURIComponent(value);
                }
            });
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-light text-center">
                <h2>Register for an Account</h2>
            </div>
            <div class="card-body">
                <div class="alert alert-danger" id="errorMessages" style="display: none;"></div>

                <form method="post" onsubmit="return validateForm();">
                    <div class="mb-3">
                        <label class="form-label">E-Mail: *</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mobile Phone: *</label>
                        <input type="text" id="phone" name="phone" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Country: *</label>
                        <select id="country" name="country" class="form-select" required>
                            <option value="">Select a country</option>
                            <option value="US">United States</option>
                            <option value="VN">Vietnam</option>
                            <option value="UK">United Kingdom</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contact me by:</label>
                        <div>
                            <input type="radio" name="contact" value="Text"> Text
                            <input type="radio" name="contact" value="Email"> Email
                            <input type="radio" name="contact" value="None" checked> Don't contact me
                        </div>
                    </div>
                    <div class="mb-3">
                        <input type="checkbox" id="terms" name="terms"> I accept *
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                    <button type="reset" class="btn btn-secondary">Reset</button>
                </form>
            </div>
        </div>

        <%
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String country = request.getParameter("country");
            String terms = request.getParameter("terms");

            if (email != null && phone != null && country != null && terms != null) {
        %>
                <div class="alert alert-success mt-3">
                    <h4>Registration Successful!</h4>
                    <p><strong>Email:</strong> <%= email %></p>
                    <p><strong>Phone:</strong> <%= phone %></p>
                    <p><strong>Country:</strong> <%= country %></p>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>
