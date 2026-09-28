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
    if (!data) return;

    const setText = (id, value) => {
        const el = document.getElementById(id);
        if (el) el.innerText = value || "Información no disponible";
    };

    setText('destino-nombre', data.nombre);
    setText('destino-ubicacion', data.departamento);
    setText('destino-descripcion', data.descripcion);

    const mainImg = document.getElementById('mainImage');
    if (mainImg) {
        if (data.imagenes && data.imagenes.length > 0) {
            mainImg.style.backgroundImage = `url('${data.imagenes[0]}')`;
        } else {
            mainImg.style.backgroundImage = `url('https://via.placeholder.com/1200x600?text=Sin+Imagen')`;
        }
    }

    setText('destino-categoria', data.categoria || "Destino Turístico");

    const avgRating = data.resenas && data.resenas.length > 0
        ? (data.resenas.reduce((acc, curr) => acc + curr.puntuacion, 0) / data.resenas.length).toFixed(1)
        : "0.0";
    setText('destino-rating', `⭐ ${avgRating}`);

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
    if (costBody) {
        const costs = data.costos || {};
        const costLabels = {
            entrada: { text: "Entrada / Acceso", icon: "fa-ticket" },
            comida: { text: "Alimentación", icon: "fa-utensils" },
            parqueo: { text: "Parqueo / Transporte", icon: "fa-car" },
            hospedaje: { text: "Hospedaje (opcional)", icon: "fa-bed" }
        };

        costBody.innerHTML = "";
        let total = 0;
        for (const [key, value] of Object.entries(costs)) {
            const valNum = parseFloat(value) || 0;
            total += valNum;
            const labelData = costLabels[key] || { text: key, icon: "fa-tag" };
            costBody.innerHTML += `
                <div class="investment-pillar">
                    <div class="pillar-info">
                        <i class="fa-solid ${labelData.icon}"></i>
                        <span>${labelData.text}</span>
                    </div>
                    <span class="pillar-amount">$${valNum.toFixed(2)}</span>
                </div>
            `;
        }
        const totalEl = document.getElementById('totalCost');
        if (totalEl) totalEl.innerText = `$${total.toFixed(2)}`;
    }

    const commentsContainer = document.getElementById('commentsContainer');
    if (commentsContainer) {
        commentsContainer.innerHTML = "";
        if (data.resenas && data.resenas.length > 0) {
            data.resenas.forEach(res => {
                commentsContainer.innerHTML += `
                    <div class="comment-box">
                        <strong>${res.usuario || 'Usuario'}</strong>
                        <p>${res.comentario || ''}</p>
                        <div class="stars-sub">${"★".repeat(res.puntuacion || 0)}${"☆".repeat(5 - (res.puntuacion || 0))}</div>
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

// --- LÓGICA DEL CARRUSEL CINEMATOGRÁFICO ---
let currentSlide = 0;

function moverCarrusel(direction = 1) {
    const track = document.getElementById('track');
    const dots = document.querySelectorAll('.dot');
    if (!track) return;

    const totalSlides = document.querySelectorAll('.carousel-slide').length;
    currentSlide = (currentSlide + direction + totalSlides) % totalSlides;

    track.style.transform = `translateX(-${currentSlide * 100}%)`;

    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
}

function irASlide(index) {
    const track = document.getElementById('track');
    const dots = document.querySelectorAll('.dot');
    if (!track) return;

    currentSlide = index;
    track.style.transform = `translateX(-${currentSlide * 100}%)`;

    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
}

