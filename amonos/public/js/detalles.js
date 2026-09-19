document.addEventListener("DOMContentLoaded", () => {
    const urlParams = new URLSearchParams(window.location.search);
    const idDestino = urlParams.get('id');

    if (!idDestino) {
        mostrarError("No se proporcionó un ID de destino válido.");
        return;
    }

    cargarDetalles(idDestino);
    inicializarRating();
});

async function cargarDetalles(id) {
    try {
        const response = await fetch(`../destinos/read_one.php?id=${id}`);
        if (!response.ok) throw new Error(`Error HTTP: ${response.status}`);

        const result = await response.json();
        if (result.success) {
            const data = result.data;
            renderizarDatos(data);
        } else {
            mostrarError(result.message);
        }
    } catch (error) {
        console.error("Fetch Error:", error);
        mostrarError("No se pudo cargar la información del destino.");
    }
}

function renderizarDatos(data) {
    document.getElementById('destino-nombre').innerText = data.nombre;
    document.getElementById('destino-ubicacion').innerText = data.departamento;
    document.getElementById('destino-descripcion').innerText = data.descripcion;

    const mainImg = document.getElementById('mainImage');
    if (data.imagenes && data.imagenes.length > 0) {
        mainImg.style.backgroundImage = `url('${data.imagenes[0]}')`;
    } else {
        mainImg.style.backgroundImage = `url('https://via.placeholder.com/1200x600?text=Sin+Imagen')`;
    }

    document.getElementById('destino-categoria').innerText = "Destino Turístico";

    const avgRating = data.resenas.length > 0
        ? (data.resenas.reduce((acc, curr) => acc + curr.puntuacion, 0) / data.resenas.length).toFixed(1)
        : "0.0";
    document.getElementById('destino-rating').innerText = `⭐ ${avgRating}`;

    const activitiesList = document.getElementById('activitiesList');
    if (activitiesList) {
        activitiesList.innerHTML = "";
        if (data.actividades && data.actividades.length > 0) {
            data.actividades.forEach(act => {
                activitiesList.innerHTML += `<li>${act}</li>`;
            });
        } else {
            activitiesList.innerHTML = "<li>No hay actividades registradas.</li>";
        }
    }

    const costBody = document.getElementById('costTableBody');
    const costs = data.costos;
    const costLabels = {
        entrada: "Entrada / Acceso",
        comida: "Alimentación",
        parqueo: "Parqueo / Transporte",
        hospedaje: "Hospedaje (opcional)"
    };

    costBody.innerHTML = "";
    let total = 0;
    for (const [key, value] of Object.entries(costs)) {
        total += value;
        costBody.innerHTML += `
            <tr>
                <td>${costLabels[key] || key}</td>
                <td>$${value.toFixed(2)}</td>
            </tr>
        `;
    }
    document.getElementById('totalCost').innerText = `$${total.toFixed(2)}`;

    const commentsContainer = document.getElementById('commentsContainer');
    if (commentsContainer) {
        commentsContainer.innerHTML = "";
        if (data.resenas && data.resenas.length > 0) {
            data.resenas.forEach(res => {
                commentsContainer.innerHTML += `
                    <div class="comment-box">
                        <strong>${res.usuario}</strong>
                        <p>${res.comentario}</p>
                        <div class="stars-sub">${"★".repeat(res.puntuacion)}${"☆".repeat(5 - res.puntuacion)}</div>
                    </div>
                `;
            });
        } else {
            commentsContainer.innerHTML = "<p style='text-align:center; color:#666;'>Aún no hay reseñas.</p>";
        }
    }
}

function inicializarRating() {
    const stars = document.querySelectorAll('.star');
    let selectedRating = 0;

    stars.forEach(star => {
        star.addEventListener('click', () => {
            selectedRating = star.getAttribute('data-value');
            stars.forEach(s => {
                s.classList.toggle('active', s.getAttribute('data-value') <= selectedRating);
            });
        });
    });
}

async function toggleHeart() {
    const urlParams = new URLSearchParams(window.location.search);
    const idDestino = urlParams.get('id');
    const btn = document.getElementById('btnFavorite');
    const icon = btn.querySelector('i');

    btn.classList.toggle('liked');
    icon.classList.toggle('fa-regular');
    icon.classList.toggle('fa-solid');

    try {
        const response = await fetch('../favoritos/toggle.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id_destino: idDestino })
        });
        const data = await response.json();
        if (!data.success) {
            btn.classList.toggle('liked');
            icon.classList.toggle('fa-regular');
            icon.classList.toggle('fa-solid');
            alert(data.message);
        }
    } catch (error) {
        console.error("Error:", error);
        btn.classList.toggle('liked');
        icon.classList.toggle('fa-regular');
        icon.classList.toggle('fa-solid');
    }
}

function irAlPlanificador() {
    const urlParams = new URLSearchParams(window.location.search);
    const id = urlParams.get('id');
    window.location.href = `planificador.html?destino=${id}`;
}

function mostrarError(mensaje) {
    alert(mensaje);
}

function agregarFotosComunidad(event) {
    const files = event.target.files;
    const grid = document.getElementById('userGalleryGrid');

    for (let file of files) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'gallery-item';
            grid.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
}
