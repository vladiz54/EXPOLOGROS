let categoriaSeleccionada = "Todos";
let departamentoSeleccionado = "Todos";

document.addEventListener("DOMContentLoaded", () => {
    inicializarFiltros();
    cargarDestinos();
    inicializarSlider();
});

function inicializarFiltros() {
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
}

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
            resultado.data.forEach(destino => {
                const tarjeta = `
                    <div class="destino-card">
                        <a href="detalles.html?id=${destino.id}" class="dest-img-sim" style="display: block; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${destino.imagen}') center/cover;"></a>
                        <div class="dest-body">
                            <div>
                                <h4><a href="detalles.html?id=${destino.id}" style="text-decoration: none; color: inherit;">${destino.nombre}</a></h4>
                                <p class="dpto">${destino.ubicacion}</p>
                            </div>
                            <div class="dest-footer">
                                <span class="price">$${parseFloat(destino.precio).toFixed(2)}</span>
                                <div class="meta-right" style="display: flex; align-items: center; gap: 8px;">
                                    <span class="rating">⭐ ${destino.rating}</span>
                                    <button class="btn-heart" data-id="${destino.id}" title="Guardar" onclick="toggleHeart(this)">❤️</button>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                contenedor.innerHTML += tarjeta;
            });
        } else {
            contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>No se encontraron destinos.</p>";
        }
    } catch (error) {
        console.error("Error:", error);
        contenedor.innerHTML = "<p style='grid-column: 1/-1; text-align: center;'>Error al conectar con el servidor.</p>";
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
