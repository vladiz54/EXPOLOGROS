// Variables globales de estado para los filtros
let categoriaSeleccionada = "Todos";
let departamentoSeleccionado = "Todos";

document.addEventListener("DOMContentLoaded", () => {
    inicializarFiltros();
    cargarDestinos();
});

function inicializarFiltros() {
    // 1. Manejo de clics en los botones de categoría
    const botonesCategoria = document.querySelectorAll(".categories-list .cat-card");
    
    // Marcar el primer botón ("Todos") como activo por defecto
    if (botonesCategoria.length > 0) {
        botonesCategoria[0].classList.add("active");
    }

    botonesCategoria.forEach(boton => {
        boton.addEventListener("click", (e) => {
            // Remover clase active de todos los botones
            botonesCategoria.forEach(b => b.classList.remove("active"));
            
            // Agregar clase active al seleccionado
            boton.classList.add("active");
            
            // Obtener el nombre de la categoría limpia de espacios extras
            categoriaSeleccionada = boton.textContent.trim();
            
            // Consultar con el nuevo filtro
            cargarDestinos();
        });
    });

    // 2. Manejo del botón de filtrar departamento
    const btnFiltrar = document.getElementById("btn-filtrar");
    const selectDept = document.getElementById("select-departamento");

    if (btnFiltrar && selectDept) {
        btnFiltrar.addEventListener("click", () => {
            departamentoSeleccionado = selectDept.value;
            cargarDestinos();
        });
    }
}

async function cargarDestinos() {
    const contenedor = document.querySelector(".grid-destinos");
    
    if (!contenedor) return;

    // Indicador visual de carga
    contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>Cargando destinos...</p>";

    try {
        // Construcción de la URL con parámetros GET encodeados
        const url = `../destinos/read.php?categoria=${encodeURIComponent(categoriaSeleccionada)}&departamento=${encodeURIComponent(departamentoSeleccionado)}`;
        
        const response = await fetch(url);
        const resultado = await response.json();

        if (resultado.success && resultado.data.length > 0) {
            contenedor.innerHTML = "";

            resultado.data.forEach(destino => {
                const imagen = destino.imagen_url ? destino.imagen_url : 'https://via.placeholder.com/400x250?text=Sin+Imagen';
                const precio = destino.precio_entrada ? `$${parseFloat(destino.precio_entrada).toFixed(2)}` : 'Gratis';
                const puntaje = destino.puntaje ? parseFloat(destino.puntaje).toFixed(1) : 'N/A';

                const tarjeta = `
                    <div class="destino-card">
                        <a href="detalles.html?id=${destino.id_destino}" class="dest-img-sim" style="display: block; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${imagen}') center/cover;"></a>
                        <div class="dest-body">
                            <div>
                                <h4><a href="detalles.html?id=${destino.id_destino}" style="text-decoration: none; color: inherit;">${destino.nombre}</a></h4>
                                <p class="dpto">${destino.departamento}</p>
                            </div>
                            <div class="dest-footer">
                                <span class="price">${precio}</span>
                                <div class="meta-right" style="display: flex; align-items: center; gap: 8px;">
                                    <span class="rating">⭐ ${puntaje}</span>
                                    <button class="btn-heart" title="Guardar" onclick="toggleHeart(event, this)">❤️</button>
                                </div>
                            </div>
                        </div>
                    </div>
                `;

                contenedor.innerHTML += tarjeta;
            });
        } else {
            contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>No se encontraron destinos para esta combinación de filtros.</p>";
        }

    } catch (error) {
        console.error("Error al cargar los destinos:", error);
        contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>Error al conectar con el servidor.</p>";
    }
}





const slides = document.querySelectorAll(".slide");
let index = 0;

function cambiarSlide() {

    // Quitar la clase active del video actual
    slides[index].classList.remove("active");

    // Pausar el video actual
    const videoActual = slides[index].querySelector("video");
    videoActual.pause();

    // Pasar al siguiente slide
    index++;

    if (index >= slides.length) {
        index = 0;
    }

    // Activar el nuevo video
    slides[index].classList.add("active");

    // Reproducir el nuevo video
    const nuevoVideo = slides[index].querySelector("video");
    nuevoVideo.currentTime = 0;
    nuevoVideo.play();
}

// Cambia cada 8 segundos
setInterval(cambiarSlide, 8000);

// Obtener lista de favoritos guardados o inicializar vacía
function obtenerFavoritos() {
    return JSON.parse(localStorage.getItem('destinosFavoritos')) || [];
}

// Guardar lista en localStorage
function guardarFavoritos(favoritos) {
    localStorage.setItem('destinosFavoritos', JSON.stringify(favoritos));
}

// Función principal para dar clic al corazón
function toggleHeart(event, btn) {
    event.stopPropagation();
    event.preventDefault();

    const destinoId = btn.getAttribute('data-id');
    const destinoDatos = {
        id: destinoId,
        nombre: btn.getAttribute('data-nombre'),
        dpto: btn.getAttribute('data-dpto'),
        precio: btn.getAttribute('data-precio'),
        img: btn.getAttribute('data-img')
    };

    let favoritos = obtenerFavoritos();
    const index = favoritos.findIndex(item => item.id === destinoId);

    if (index === -1) {
        // No estaba guardado -> Lo agregamos y cambiamos a rojo
        favoritos.push(destinoDatos);
        btn.innerText = "❤️";
        btn.classList.add('active');
    } else {
        // Ya estaba guardado -> Lo quitamos y vuelve a negro/blanco
        favoritos.splice(index, 1);
        btn.innerText = "🤍";
        btn.classList.remove('active');
    }

    guardarFavoritos(favoritos);

    // Animación al presionar
    btn.style.transform = "scale(1.3)";
    setTimeout(() => { btn.style.transform = "scale(1)"; }, 150);
}

// Al cargar la página, restaurar el estado (rojo si ya está guardado)
document.addEventListener('DOMContentLoaded', () => {
    const favoritos = obtenerFavoritos();
    const botones = document.querySelectorAll('.btn-heart');

    botones.forEach(btn => {
        const id = btn.getAttribute('data-id');
        const existe = favoritos.some(item => item.id === id);
        if (existe) {
            btn.innerText = "❤️";
            btn.classList.add('active');
        } else {
            btn.innerText = "🤍";
            btn.classList.remove('active');
        }
    });
});