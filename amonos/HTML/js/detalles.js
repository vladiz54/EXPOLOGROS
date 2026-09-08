// --- BASE DE DATOS LOCAL (Simulación de la tabla 'destinos' y sus relaciones) ---
const destinosData = {
    "1": {
        id: 1,
        nombre: "Playa El Tunco",
        departamento: "La Libertad, El Salvador",
        estrellas: "★★★★★",
        descripcion: "Una de las playas más famosas de El Salvador para el surf, con una icónica formación rocosa y una vibrante vida nocturna.",
        actividades: [
            "Práctica y clases de surf",
            "Disfrutar de atardeceres frente al mar",
            "Gastronomía en restaurantes locales",
            "Vida nocturna y música en vivo"
        ],
        imagenes: [
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80",
            "https://images.unsplash.com/photo-1519046904884-53103b34b206?auto=format&fit=crop&w=1200&q=80",
            "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=1200&q=80"
        ],
        costos: {
            transporte: 5.00,
            comida: 15.00,
            entradas: 0.00
        }
    },
    "2": {
        id: 2,
        nombre: "Lago de Coatepeque",
        departamento: "Santa Ana, El Salvador",
        estrellas: "★★★★★",
        descripcion: "Uno de los lagos más hermosos de Centroamérica, conocido por sus aguas cristalinas y actividades recreativas. En ciertas épocas del año, sus aguas cambian a un color turquesa impresionante.",
        actividades: [
            "Paseos en lancha y jet ski",
            "Nadar en zonas autorizadas",
            "Comer en restaurantes frente al lago",
            "Fotografiar paisajes panorámicos"
        ],
        imagenes: [
            "https://lh3.googleusercontent.com/blogger_img_proxy/AEn0k_sKnA717uPjGlirSF_Zlun7yo1f1dLBT-5rpjN8d9lB3DwrLxUW7AEQeDOJow2AR1gLgCMItSIR5GaAt1YMcOJ4JpKM9oTdc9lfBJo7z_0fcKtXaKcB__79clzHNzoJBnw=s0-d",
            "https://i0.wp.com/www.chiquithetraveller.com/wp-content/uploads/2018/05/lago-coatepeque-el-salvador-muelle.jpg?w=1280&ssl=1",
            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhH3T7grCL48wC1poE8SYJBw9_Maq7nZmIKBVFbfPGdx7USnbN2AgBnJcfAEp0ycAOMpVOBHMx9Ywqj73COym55QhGlKUiM7HgK6X8cplcCJGV3jWHU7PHgeXjDA-Unxlwk_NpcYKHTdeQ/s1600/maxresdefault.jpg"
        ],
        costos: {
            transporte: 10.00,
            comida: 12.00,
            entradas: 5.00
        }
    }
};

// --- ESTADO GLOBAL ---
let currentSlide = 0;
let selectedRating = 5;
let destinoActual = null;

// --- INICIALIZACIÓN ---
document.addEventListener('DOMContentLoaded', () => {
    cargarDetallesDestino();
    inicializarCalificacionEstrellas();
    inicializarFormularioResenas();
});

// --- CARGA DINÁMICA DE DATOS ---
function cargarDetallesDestino() {
    // Extraer parámetro 'id' de la URL (Ejemplo: detalles.html?id=1)
    const urlParams = new URLSearchParams(window.location.search);
    const idParam = urlParams.get('id') || "2"; // 2 (Coatepeque) por defecto si no viene parámetro

    destinoActual = destinosData[idParam] || destinosData["2"];

    // 1. Título y Estrellas
    document.getElementById('destino-nombre').textContent = destinoActual.nombre;
    const starsContainer = document.querySelector('.destination-header .stars');
    if (starsContainer) starsContainer.textContent = destinoActual.estrellas;

    // 2. Ubicación y Descripción
    const locationTag = document.querySelector('.location-tag');
    if (locationTag) locationTag.textContent = `📍 ${destinoActual.departamento}`;

    const descriptionText = document.querySelector('.description-text');
    if (descriptionText) descriptionText.textContent = destinoActual.descripcion;

    // 3. Actividades
    const activitiesList = document.querySelector('.activities-list');
    if (activitiesList) {
        activitiesList.innerHTML = destinoActual.actividades
            .map(act => `<li>${act}</li>`)
            .join('');
    }

    // 4. Carrusel de Imágenes
    const track = document.getElementById('track');
    if (track && destinoActual.imagenes.length > 0) {
        track.innerHTML = destinoActual.imagenes
            .map(imgUrl => `<div class="carousel-slide" style="background-image: url('${imgUrl}');"></div>`)
            .join('');
    }

    // 5. Tabla de Costos
    const total = destinoActual.costos.transporte + destinoActual.costos.comida + destinoActual.costos.entradas;
    const tablaCostosBody = document.querySelector('.table-costs tbody');
    if (tablaCostosBody) {
        tablaCostosBody.innerHTML = `
            <tr>
                <td>🚌 Transporte / Pasaje</td>
                <td>$${destinoActual.costos.transporte.toFixed(2)}</td>
            </tr>
            <tr>
                <td>🍽️ Alimentación</td>
                <td>$${destinoActual.costos.comida.toFixed(2)}</td>
            </tr>
            <tr>
                <td>🎟️ Lancha / Entradas</td>
                <td>$${destinoActual.costos.entradas.toFixed(2)}</td>
            </tr>
            <tr class="row-total">
                <td><strong>Total estimado base:</strong></td>
                <td><strong>$${total.toFixed(2)}</strong></td>
            </tr>
        `;
    }
}

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

// --- 5. REDIRECCIÓN AL PLANIFICADOR CON VALORES REALES ---
function irAlPlanificador() {
    if (!destinoActual) return;

    const destino = destinoActual.nombre;
    const transporte = destinoActual.costos.transporte;
    const comida = destinoActual.costos.comida;
    const entradas = destinoActual.costos.entradas;

    window.location.href = `planificador.html?destino=${encodeURIComponent(destino)}&transporte=${transporte}&comida=${comida}&entradas=${entradas}`;
}