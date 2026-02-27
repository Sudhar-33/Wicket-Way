/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* ================= LIVE COUNTERS ================= */
function animateCounter(id, target) {
    let count = 0;
    const speed = 20;
    const element = document.getElementById(id);

    const interval = setInterval(() => {
        count++;
        element.innerText = count;
        if (count >= target) clearInterval(interval);
    }, speed);
}

document.addEventListener("DOMContentLoaded", () => {
    animateCounter("matchesCount", 18);
    animateCounter("stadiumCount", 12);
    animateCounter("bookingCount", 1500);
});

/* ================= SEARCH FILTER ================= */
const searchInput = document.getElementById("searchInput");

if (searchInput) {
    searchInput.addEventListener("keyup", function () {
        const value = this.value.toLowerCase();
        const items = document.querySelectorAll(".stadium-item");

        items.forEach(item => {
            const text = item.dataset.name.toLowerCase();
            item.style.display = text.includes(value) ? "block" : "none";
        });
    });
}

/* ================= SMOOTH SCROLL ================= */
document.querySelectorAll("a[href^='#']").forEach(anchor => {
    anchor.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute("href"))
            .scrollIntoView({ behavior: "smooth" });
    });
});

