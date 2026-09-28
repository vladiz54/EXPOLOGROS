let categoriaSeleccionada = "Todos";
let departamentoSeleccionado = "Todos";

document.addEventListener("DOMContentLoaded", () => {
    const botonesCategoria = document.querySelectorAll(".categories-list .cat-card");
    if (botonesCategoria.length > 0) {
        botonesCategoria[0].classList.add("active");
    }

    botonesCategoria.forEach(boton => {
        boton.addEventListener("click", (e) => {
            botonesCategoria.forEach(b => b.classList.remove("active"));
            boton.classList.add("active");
            categoriaSeleccionada = boton.textContent.trim();
            cargarDestinos();
        });
    });

    const btnFiltrar = document.getElementById("btn-filtrar");
    const selectDept = document.getElementById("select-departamento");
    if (btnFiltrar && selectDept) {
        btnFiltrar.addEventListener("click", () => {
            departamentoSeleccionado = selectDept.value;
            cargarDestinos();
        });
    }

    inicializarSlider();
});

// Removed legacy counter functions to clean up the code
async function cargarDestinos() {
// ... the rest of the file remains the same ...


async function cargarDestinos() {
    const contenedor = document.querySelector(".grid-destinos");
    if (!contenedor) return;

    contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>Cargando destinos...</p>";

    try {
        const url = `../destinos/read.php?categoria=${encodeURIComponent(categoriaSeleccionada)}&departamento=${encodeURIComponent(departamentoSeleccionado)}`;
        const response = await fetch(url);
        const resultado = await response.json();

        if (resultado.success && resultado.data.length > 0) {
            contenedor.innerHTML = "";

            // LÍMITE DE DESTINOS PARA EL INDEX (UX Optimization)
            const LIMIT_INDEX = 8;
            const totalDestinos = resultado.data.length;
            const destinosAMostrar = resultado.data.slice(0, LIMIT_INDEX);

            destinosAMostrar.forEach(destino => {
                const descripcionCorta = destino.descripcion
                    ? (destino.descripcion.length > 70 ? destino.descripcion.substring(0, 67) + '...' : destino.descripcion)
                    : "Discover this incredible destination and live an unforgettable experience.";

                const tarjeta = `
                    <div class="destino-card">
                        <a href="detalles.html?id=${destino.id}" class="card-link-wrapper" style="text-decoration: none; color: inherit; display: block;">
                            <div class="dest-img-container">
                                <div class="dest-img-sim" style="background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${destino.imagen}') center/cover; height: 230px;"></div>
                            </div>
                            <div class="dest-body">
                                <div class="dest-info">
                                    <h4>${destino.nombre}</h4>
                                    <p class="dpto">${destino.ubicacion}</p>
                                    <p class="dest-short-desc" style="font-size: 0.85rem; color: var(--text-muted); margin: 8px 0 15px 0; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${descripcionCorta}</p>
                                </div>
                                <div class="dest-footer">
                                    <span class="price">$${parseFloat(destino.precio || 0).toFixed(2)}</span>
                                    <div class="meta-right" style="display: flex; align-items: center; gap: 8px;">
                                        <span class="rating">⭐ ${destino.rating || '0.0'}</span>
                                        <button class="btn-heart" data-id="${destino.id}" title="Guardar" onclick="toggleHeart(event, this)">❤️</button>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                `;
                contenedor.innerHTML += tarjeta;
            });

            // AGREGAR BOTÓN "VER MÁS" SI EXCEDEN EL LÍMITE
            if (totalDestinos > LIMIT_INDEX) {
                const btnVerMas = document.createElement("div");
                btnVerMas.style.gridColumn = "1 / -1";
                btnVerMas.style.display = "flex";
                btnVerMas.style.justifyContent = "center";
                btnVerMas.style.marginTop = "40px";
                btnVerMas.style.marginBottom = "40px";

                // Construimos la URL para explorar.html pasando los filtros actuales
                const exploreUrl = `explorar.html?categoria=${encodeURIComponent(categoriaSeleccionada)}&departamento=${encodeURIComponent(departamentoSeleccionado)}`;

                btnVerMas.innerHTML = `
                    <a href="${exploreUrl}" class="btn-primary" style="padding: 15px 40px; text-decoration: none; border-radius: 50px; font-weight: 700; font-family: 'Poppins', sans-serif; transition: all 0.3s ease; box-shadow: 0 10px 20px rgba(3, 105, 161, 0.2);">
                        Explorar más destinos <i class="fa-solid fa-arrow-right" style="margin-left: 10px;"></i>
                    </a>
                `;
                contenedor.appendChild(btnVerMas);
            }

        } else {
            contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>No destinations found.</p>";
        }
    } catch (error) {
        console.error("Error:", error);
        contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>Error connecting to the server.</p>";
    }
    }
}

async function toggleHeart(btn) {
    const idDestino = btn.getAttribute('data-id');
    btn.classList.toggle('liked');
    btn.style.transform = "scale(1.3)";
    setTimeout(() => btn.style.transform = "scale(1)", 150);

    try {
        const response = await fetch('../favoritos/toggle.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id_destino: idDestino })
        });
        const data = await response.json();
        if (!data.success) {
            btn.classList.toggle('liked');
            alert(data.message);
        }
    } catch (error) {
        btn.classList.toggle('liked');
        console.error("Error:", error);
    }
}

function inicializarSlider() {
    const slides = document.querySelectorAll(".slide");
    if (!slides.length) return;
    let index = 0;

    function cambiarSlide() {
        slides[index].classList.remove("active");
        const videoActual = slides[index].querySelector("video");
        if (videoActual) videoActual.pause();

        index = (index + 1) % slides.length;

        slides[index].classList.add("active");
        const nuevoVideo = slides[index].querySelector("video");
        if (nuevoVideo) {
            nuevoVideo.currentTime = 0;
            nuevoVideo.play().catch(() => {});
        }
    }
    setInterval(cambiarSlide, 8000);
}
