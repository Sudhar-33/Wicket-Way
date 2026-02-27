/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function validateRegister() {

    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let mobile = document.getElementById("mobile").value.trim();
    let pass = document.getElementById("password").value;
    let confirm = document.getElementById("confirm").value;
    let error = document.getElementById("errorMsg");

    if (name === "" || email === "" || mobile === "" || pass === "" || confirm === "") {
        error.innerHTML = "⚠ All fields are required";
        return false;
    }

    if (!/^\d{10}$/.test(mobile)) {
        error.innerHTML = "⚠ Enter valid 10-digit mobile number";
        return false;
    }

    if (pass.length < 4) {
        error.innerHTML = "⚠ Password must be at least 4 characters";
        return false;
    }

    if (pass !== confirm) {
        error.innerHTML = "⚠ Passwords do not match";
        return false;
    }

    return true;
}
