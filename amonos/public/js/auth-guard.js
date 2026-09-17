/**
 * AuthGuard - Sistema de protección de rutas y anti-caché
 * Asegura que el usuario tenga una sesión activa y evita el acceso mediante el botón "Atrás"
 */

(function() {
    // 1. Forzar recarga si la página viene del BFCache (botón atrás/adelante)
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

    // 2. Función para verificar la sesión en el servidor
    async function checkSession() {
        try {
            const response = await fetch('../auth/read_profile.php');
            if (response.status === 401 || !response.ok) {
                redirectToLogin();
            } else {
                const result = await response.json();
                if (!result.success) {
                    redirectToLogin();
                }
            }
        } catch (error) {
            console.error('Error verificando sesión:', error);
            redirectToLogin();
        }
    }

    function redirectToLogin() {
        // Evitar bucle infinito si ya estamos en la página de sesión
        if (!window.location.pathname.includes('sesion.html')) {
            window.location.href = 'sesion.html';
        }
    }

    // Ejecutar comprobación inmediatamente al cargar
    checkSession();
})();
