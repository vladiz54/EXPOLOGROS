let currentSlide = 0;
let selectedRating = 5;
let destinoActual = null;

document.addEventListener('DOMContentLoaded', () => {
    obtenerDestinoDesdeBD();
    inicializarCalificacionEstrellas();
    inicializarFormularioResenas();
});

async function obtenerDestinoDesdeBD() {
    const urlParams = new URLSearchParams(window.location.search);
    const idDestino = urlParams.get('id') || 1;

    try {
        const response = await fetch(`../destinos/read_one.php?id=${idDestino}`);
        if (!response.ok) throw new Error('No se pudo obtener la información');

        const result = await response.json();
        if (result.success) {
            destinoActual = result.data;
            renderizarInterfaz(destinoActual);
        } else {
            console.error('Error:', result.message);
        }
    } catch (error) {
        console.error('Error cargando destino:', error);
    }
}

function renderizarInterfaz(destino) {
    const elemNombre = document.getElementById('destino-nombre');
    if (elemNombre) elemNombre.textContent = destino.nombre;

    const locationTag = document.querySelector('.location-tag');
    if (locationTag) locationTag.textContent = `📍 ${destino.departamento}, El Salvador`;

    const descText = document.querySelector('.description-text');
    if (descText) descText.textContent = destino.descripcion;

    const activitiesList = document.querySelector('.activities-list');
    if (activitiesList && destino.actividades.length > 0) {
        activitiesList.innerHTML = destino.actividades
            .map(act => `<li>${act}</li>`)
            .join('');
    }

    const track = document.getElementById('track');
    if (track && destino.imagenes.length > 0) {
        track.innerHTML = destino.imagenes
            .map(url => `<div class="carousel-slide" style="background-image: url('${url}');"></div>`)
            .join('');
    }

    const c = destino.costos;
    const totalBase = (c.entrada || 0) + (c.comida || 0) + (c.parqueo || 0);
    const tablaCostos = document.querySelector('.table-costs tbody');
    if (tablaCostos) {
        tablaCostos.innerHTML = `
            <tr><td>🎟️ Entrada</td><td>$${(c.entrada || 0).toFixed(2)}</td></tr>
            <tr><td>🍽️ Alimentación</td><td>$${(c.comida || 0).toFixed(2)}</td></tr>
            <tr><td>🅿️ Parqueo</td><td>$${(c.parqueo || 0).toFixed(2)}</td></tr>
            <tr><td>🏨 Hospedaje</td><td>$${(c.hospedaje || 0).toFixed(2)}</td></tr>
            <tr class="row-total">
                <td><strong>Total estimado base:</strong></td>
                <td><strong>$${totalBase.toFixed(2)}</strong></td>
            </tr>
        `;
    }

    const commentsContainer = document.getElementById('commentsContainer');
    if (commentsContainer && destino.resenas.length > 0) {
        commentsContainer.innerHTML = destino.resenas.map(r => `
            <div class="comment-box">
                <strong>${r.usuario.toUpperCase()}:</strong>
                <p>${escaparHTML(r.comentario)}</p>
                <div class="stars-sub">${'★'.repeat(r.puntuacion)}${'☆'.repeat(5 - r.puntuacion)}</div>
            </div>
        `).join('');
    }
}

function moverCarrusel(direccion) {
    const track = document.getElementById('track');
    const slides = document.querySelectorAll('.carousel-slide');
    if (!slides.length) return;

    currentSlide += direccion;
    if (currentSlide < 0) currentSlide = slides.length - 1;
    else if (currentSlide >= slides.length) currentSlide = 0;

    track.style.transform = `translateX(-${currentSlide * 100}%)`;
}

function inicializarCalificacionEstrellas() {
    const starSelects = document.querySelectorAll('.star-select');
    starSelects.forEach((star, index) => {
        star.addEventListener('mouseover', () => resaltarEstrellas(index + 1));
        star.addEventListener('mouseout', () => resaltarEstrellas(selectedRating));
        star.addEventListener('click', () => {
            selectedRating = index + 1;
            resaltarEstrellas(selectedRating);
        });
    });
    resaltarEstrellas(selectedRating);
}

function resaltarEstrellas(cantidad) {
    const starSelects = document.querySelectorAll('.star-select');
    starSelects.forEach((star, i) => {
        star.style.color = (i < cantidad) ? '#ffb703' : '#cbd5e1';
    });
}

function inicializarFormularioResenas() {
    const reviewForm = document.getElementById('reviewForm');
    const reviewText = document.getElementById('reviewText');
    const commentsContainer = document.getElementById('commentsContainer');

    if (!reviewForm) return;

    reviewForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const texto = reviewText.value.trim();
        if (!texto) return;

        const newComment = document.createElement('div');
        newComment.className = 'comment-box';
        newComment.innerHTML = `
            <strong>DIEGO (TÚ):</strong>
            <p>${escaparHTML(texto)}</p>
            <div class="stars-sub">${'★'.repeat(selectedRating)}${'☆'.repeat(5 - selectedRating)}</div>
        `;
        commentsContainer.insertBefore(newComment, commentsContainer.firstChild);
        reviewText.value = '';
        selectedRating = 5;
        resaltarEstrellas(selectedRating);
    });
}

function escaparHTML(str) {
    return str.replace(/[&<>'"]/g, tag => ({
        '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;'
    }[tag] || tag));
}

function irAlPlanificador() {
    if (!destinoActual) return;
    const nombre = destinoActual.nombre;
    const c = destinoActual.costos;
    window.location.href = `planificador.html?destino=${encodeURIComponent(nombre)}&transporte=${c.entrada}&comida=${c.comida}&entradas=${c.parqueo}`;
}
