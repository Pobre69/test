function toggleMenu() {
    const navMenu = document.getElementById('navMenu');
    navMenu.classList.toggle('active');
}

document.addEventListener('click', function(event) {
    const navbar = document.getElementById('navbar');
    const navMenu = document.getElementById('navMenu');
    
    if (!navbar.contains(event.target)) {
        navMenu.classList.remove('active');
    }
});