document.addEventListener("DOMContentLoaded", () => {
    const registerForm = document.getElementById("registerForm");
    const btnTogglePassword = document.querySelector(".btn-toggle-password");
    const passwordInput = document.getElementById("password");

    if (btnTogglePassword && passwordInput) {
        btnTogglePassword.addEventListener("click", () => {
            const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
            passwordInput.setAttribute("type", type);
        });
    }

    if (registerForm) {
        registerForm.addEventListener("submit", async (e) => {
            e.preventDefault();
            ocultarAlerta();
            await registrarUsuario();
        });
    }
});

async function registrarUsuario() {
    const nameInput = document.getElementById("name").value.trim();
    const emailInput = document.getElementById("email").value.trim();
    const passwordInput = document.getElementById("password").value.trim();

    if (!nameInput || !emailInput || !passwordInput) {
        mostrarAlerta("Por favor, completa todos los campos.", "danger");
        return;
    }

    if (passwordInput.length < 8) {
        mostrarAlerta("La contraseña debe tener al menos 8 caracteres.", "danger");
        return;
    }

    const payload = {
        nombre: nameInput,
        correo: emailInput,
        password: passwordInput
    };

    try {
        const response = await fetch("../auth/registro.php", {
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
            
            document.getElementById("registerForm").reset();
            setTimeout(() => {
                window.location.href = "sesion.html";
            }, 1500);
        } else {
            mostrarAlerta(data.message, "danger");
        }

    } catch (error) {
        console.error("Error al procesar el registro:", error);
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