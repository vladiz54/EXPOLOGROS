document.addEventListener("DOMContentLoaded", () => {
    const urlParams = new URLSearchParams(window.location.search);
    const idDestino = urlParams.get('id');

    if (!idDestino) {
        mostrarError("A valid destination ID was not provided.");
        return;
    }

    cargarDetalles(idDestino);
    inicializarRating();
});

async function cargarDetalles(id) {
    try {
        const response = await fetch(`../destinos/read_one.php?id=${id}`);
        if (!response.ok) throw new Error(`HTTP Error: ${response.status}`);

        const result = await response.json();
        if (result.success) {
            const data = result.data;
            renderizarDatos(data);
        } else {
            mostrarError(result.message);
        }
    } catch (error) {
        console.error("Fetch Error:", error);
        mostrarError("Could not load destination information.");
    }
}

function translateText(text) {
    if (!text) return "";

    const translations = {
        // Activities
        "nadar en zonas seguras": "swim in safe areas",
        "disfrutar el atardecer": "enjoy the sunset",
        "senderismo por el volcán": "hiking through the volcano",
        "visitar el casco histórico": "visit the historic downtown",
        "probar la comida local": "try local food",
        "fotografía de paisajes": "landscape photography",
        "visitar museos": "visit museums",
        "explorar rutas ocultas": "explore hidden routes",
        "paseo en bote": "boat ride",
        "observación de aves": "bird watching",
        "visita a cafeterías locales": "visit local coffee shops",

        // Categories/General
        "Destino Turístico": "Tourist Destination",
        "Naturaleza": "Nature",
        "Playa": "Beach",
        "Aventura": "Adventure",
        "Cultura": "Culture",
        "Gastronomía": "Gastronomy",
        "Pueblos Vivos": "Living Towns",
        "Montaña": "Mountain"
    };

    const lowerText = text.toLowerCase().trim();
    return translations[lowerText] || text;
}

function renderizarDatos(data) {
    if (!data) return;

    const setText = (id, value) => {
        const el = document.getElementById(id);
        if (el) el.innerText = value || "Information not available";
    };

    setText('destino-nombre', data.nombre);
    setText('destino-ubicacion', data.departamento);

    // Translate description if it exists (simple replacement or you can add more logic here)
    setText('destino-descripcion', data.descripcion);

    const track = document.getElementById('track');
    const dotsContainer = document.getElementById('carouselDots');
    if (!track || !dotsContainer) return;

    const images = data.imagenes || [];
    track.innerHTML = "";
    dotsContainer.innerHTML = "";

    if (images.length > 0) {
        images.forEach((url, index) => {
            // Create slide
            const slide = document.createElement('div');
            slide.className = 'carousel-slide';
            slide.style.backgroundImage = `url('${url}')`;
            track.appendChild(slide);

            // Create dot
            const dot = document.createElement('span');
            dot.className = `dot ${index === 0 ? 'active' : ''}`;
            dot.onclick = () => irASlide(index);
            dotsContainer.appendChild(dot);
        });
    } else {
        track.innerHTML = '<div class="carousel-slide" style="background-image: url(\'https://via.placeholder.com/1200x600?text=No+Images+Available\')"></div>';
    }

    // Reset carousel position
    currentSlide = 0;
    track.style.transform = 'translateX(0%)';


    const avgRating = data.resenas && data.resenas.length > 0
        ? (data.resenas.reduce((acc, curr) => acc + curr.puntuacion, 0) / data.resenas.length).toFixed(1)
        : "0.0";
    setText('destino-rating', `⭐ ${avgRating}`);

    const activitiesList = document.getElementById('activitiesList');
    if (activitiesList) {
        activitiesList.innerHTML = "";
        if (data.actividades && data.actividades.length > 0) {
            data.actividades.forEach(act => {
                activitiesList.innerHTML += `<li>${translateText(act)}</li>`;
            });
        } else {
            activitiesList.innerHTML = "<li>No activities registered.</li>";
        }
    }

    const costBody = document.getElementById('costTableBody');
    if (costBody) {
        const costs = data.costos || {};
        const costLabels = {
            entrada: { text: "Entrance / Access", icon: "fa-ticket" },
            comida: { text: "Food & Dining", icon: "fa-utensils" },
            parqueo: { text: "Parking / Transport", icon: "fa-car" },
            hospedaje: { text: "Lodging (optional)", icon: "fa-bed" }
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
                        <strong>${res.usuario || 'User'}</strong>
                        <p>${res.comentario || ''}</p>
                        <div class="stars-sub">${"★".repeat(res.puntuacion || 0)}${"☆".repeat(5 - (res.puntuacion || 0))}</div>
                    </div>
                `;
            });
        } else {
            commentsContainer.innerHTML = "<p style='text-align:center; color:#666;'>No reviews yet.</p>";
        }
    }
}

function inicializarRating() {
    const stars = document.querySelectorAll('.star-select');
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
            img.className = 'user-gallery-item';

            // Randomly assign Masonry classes for a dynamic look
            const rand = Math.random();
            if (rand > 0.8) img.classList.add('tall');
            else if (rand > 0.6) img.classList.add('wide');

            grid.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
}

// --- CINEMATIC CAROUSEL LOGIC ---
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
