/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function validateLogin() {
    let username = document.getElementById("username").value.trim();
    let password = document.getElementById("password").value.trim();
    let error = document.getElementById("errorMsg");

    if (username === "" || password === "") {
        error.innerHTML = "⚠ Please fill in all fields";
        return false;
    }

    if (password.length < 4) {
        error.innerHTML = "⚠ Password must be at least 4 characters";
        return false;
    }

    return true;
}
