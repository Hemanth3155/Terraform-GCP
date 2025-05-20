// Smooth scrolling
document.querySelectorAll("nav a").forEach(anchor => {
  anchor.addEventListener("click", function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute("href"));
    target.scrollIntoView({ behavior: "smooth" });
  });
});

// Form interaction
document.getElementById("contactForm").addEventListener("submit", function(e) {
  e.preventDefault();
  document.getElementById("responseMsg").textContent = "Thanks! I'll get back to you shortly.";
  this.reset();
});

// Reveal on scroll
function reveal() {
  const reveals = document.querySelectorAll(".reveal");
  let delay = 0;
  for (let r of reveals) {
    const windowHeight = window.innerHeight;
    const elementTop = r.getBoundingClientRect().top;
    const elementVisible = 150;
    if (elementTop < windowHeight - elementVisible) {
      setTimeout(() => r.classList.add("active"), delay);
      delay += 300; // staggered reveal
    }
  }
}
window.addEventListener("scroll", reveal);
window.addEventListener("load", reveal);
