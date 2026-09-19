/**
 * Header Interaction Script
 * Añade efectos dinámicos al navegar por la página
 */
(function() {
    window.addEventListener('scroll', () => {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
})();
