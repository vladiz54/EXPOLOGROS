// --- ESTADO GLOBAL ---
let currentSlide = 0;
let selectedRating = 5;

// --- INICIALIZACIÓN ---
document.addEventListener('DOMContentLoaded', () => {
    inicializarCalificacionEstrellas();
    inicializarFormularioResenas();
});

// --- 1. CARRUSEL DE IMÁGENES ---
function moverCarrusel(direccion) {
    const track = document.getElementById('track');
    const slides = document.querySelectorAll('.carousel-slide');
    if (!slides.length) return;

    currentSlide += direccion;

    if (currentSlide < 0) {
        currentSlide = slides.length - 1;
    } else if (currentSlide >= slides.length) {
        currentSlide = 0;
    }

    track.style.transform = `translateX(-${currentSlide * 100}%)`;
}

// --- 2. GALERÍA DE COMUNIDAD ---
function agregarFotosComunidad(event) {
    const files = event.target.files;
    const galleryGrid = document.getElementById('userGalleryGrid');

    if (!files || files.length === 0) return;

    Array.from(files).forEach(file => {
        if (file.type.startsWith('image/')) {
            const reader = new FileReader();

            reader.onload = (e) => {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'user-gallery-item';
                img.alt = 'Foto subida por usuario';
                
                galleryGrid.insertBefore(img, galleryGrid.firstChild);
            };

            reader.readAsDataURL(file);
        }
    });

    event.target.value = '';
}

// --- 3. SELECCIÓN DE ESTRELLAS ---
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

// --- 4. PUBLICACIÓN DE RESEÑAS ---
function inicializarFormularioResenas() {
    const reviewForm = document.getElementById('reviewForm');
    const reviewText = document.getElementById('reviewText');
    const commentsContainer = document.getElementById('commentsContainer');

    if (!reviewForm) return;

    reviewForm.addEventListener('submit', (e) => {
        e.preventDefault();

        const texto = reviewText.value.trim();
        if (!texto) return;

        const estrellasTexto = '★'.repeat(selectedRating) + '☆'.repeat(5 - selectedRating);

        const newComment = document.createElement('div');
        newComment.className = 'comment-box';
        newComment.innerHTML = `
            <strong>DIEGO (TÚ):</strong>
            <p>${escaparHTML(texto)}</p>
            <div class="stars-sub">${estrellasTexto}</div>
        `;

        commentsContainer.insertBefore(newComment, commentsContainer.firstChild);

        reviewText.value = '';
        selectedRating = 5;
        resaltarEstrellas(selectedRating);
    });
}

function escaparHTML(str) {
    return str.replace(/[&<>'"]/g, 
        tag => ({
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            "'": '&#39;',
            '"': '&quot;'
        }[tag] || tag)
    );
}

// --- 5. REDIRECCIÓN AL PLANIFICADOR ---
function irAlPlanificador() {
    const destino = document.getElementById('destino-nombre')?.textContent || 'coatepeque';
    const transporte = 10;
    const comida = 12;
    const entradas = 5;

    window.location.href = `planificador.html?destino=${encodeURIComponent(destino)}&transporte=${transporte}&comida=${comida}&entradas=${entradas}`;
}