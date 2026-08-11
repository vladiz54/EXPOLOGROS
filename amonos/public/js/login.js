document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.getElementById("loginForm");
    const alertBox = document.getElementById("alertMessage");
    const btnTogglePassword = document.querySelector(".btn-toggle-password");
    const passwordInput = document.getElementById("password");

    if (btnTogglePassword && passwordInput) {
        btnTogglePassword.addEventListener("click", () => {
            const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
            passwordInput.setAttribute("type", type);
        });
    }

    if (loginForm) {
        loginForm.addEventListener("submit", async (e) => {
            e.preventDefault();
            ocultarAlerta();
            await iniciarSesion();
        });
    }
});

async function iniciarSesion() {
    const emailInput = document.getElementById("email").value.trim();
    const passwordInput = document.getElementById("password").value.trim();

    if (!emailInput || !passwordInput) {
        mostrarAlerta("Por favor, completa todos los campos.", "danger");
        return;
    }

    const payload = {
        correo: emailInput,
        password: passwordInput
    };

    try {
        const response = await fetch("../auth/login.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        });

        if (!response.ok) {
            throw new Error(`Error en la petición: ${response.status}`);
        }

        const data = await response.json();

        if (data.success) {
            mostrarAlerta(data.message, "success");
            setTimeout(() => {
                window.location.href = "pagina1.html";
            }, 1200);
        } else {
            mostrarAlerta(data.message, "danger");
        }

    } catch (error) {
        console.error("Error al procesar la solicitud:", error);
        mostrarAlerta("Ocurrió un error al conectar con el servidor.", "danger");
    }
}

function mostrarAlerta(mensaje, tipo) {
    const alertBox = document.getElementById("alertMessage");
    if (alertBox) {
        alertBox.textContent = mensaje;
        alertBox.className = `alert alert-${tipo}`;
        alertBox.classList.remove("d-none");
    }
}

function ocultarAlerta() {
    const alertBox = document.getElementById("alertMessage");
    if (alertBox) {
        alertBox.classList.add("d-none");
        alertBox.textContent = "";
    }
}