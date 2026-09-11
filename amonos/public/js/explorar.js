document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById('searchInput');
    const categoryChips = document.querySelectorAll('.chip[data-category]');

    cargarDestinos();

    if (searchInput) {
        searchInput.addEventListener('input', aplicarFiltros);
    }

    categoryChips.forEach(chip => {
        chip.addEventListener('click', (e) => {
            categoryChips.forEach(c => c.classList.remove('active'));
            e.target.classList.add('active');
            aplicarFiltros();
        });
    });
});

let destinosBD = [];
let categoriaSeleccionada = "todos";

async function cargarDestinos() {
    const resultsCount = document.getElementById('resultsCount');
    const cardsGrid = document.getElementById('cardsGrid');

    if (resultsCount) resultsCount.innerText = "Cargando destinos...";

    try {
        const response = await fetch('../destinos/read.php');
        if (!response.ok) throw new Error(`Error HTTP: ${response.status}`);

        const result = await response.json();
        if (result.success) {
            destinosBD = result.data;
            aplicarFiltros();
        } else {
            mostrarError(result.message || "Error al cargar destinos");
        }
    } catch (error) {
        console.error("Fetch Error:", error);
        mostrarError("No se pudo conectar con el servidor.");
    }
}

function aplicarFiltros() {
    const searchInput = document.getElementById('searchInput');
    const cardsGrid = document.getElementById('cardsGrid');
    const resultsCount = document.getElementById('resultsCount');

    const texto = searchInput ? searchInput.value.toLowerCase().trim() : "";
    const activeChip = document.querySelector('.chip[data-category].active');
    const cat = activeChip ? activeChip.getAttribute('data-category').toLowerCase() : "todos";

    const filtrados = destinosBD.filter(dest => {
        const coincideTexto = dest.nombre.toLowerCase().includes(texto) ||
                              dest.ubicacion.toLowerCase().includes(texto);
        const coincideCat = (cat === "todos") || (dest.categoria.toLowerCase() === cat);
        return coincideTexto && coincideCat;
    });

    renderizarDestinos(filtrados);
}

function renderizarDestinos(lista) {
    const cardsGrid = document.getElementById('cardsGrid');
    const resultsCount = document.getElementById('resultsCount');

    if (!cardsGrid) return;
    cardsGrid.innerHTML = "";

    if (lista.length === 0) {
        cardsGrid.innerHTML = `<p style="grid-column: 1/-1; text-align: center; color: #666; padding: 20px;">No se encontraron destinos.</p>`;
        if (resultsCount) resultsCount.innerText = "0 resultados encontrados";
        return;
    }

    if (resultsCount) resultsCount.innerText = `Se encontraron ${lista.length} destinos`;

    lista.forEach(dest => {
        const cardHTML = `
            <div class="card-destino">
                <a href="detalles.html?id=${dest.id}"
                   class="card-img-sim"
                   style="display: block; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${dest.imagen}') center/cover;">
                </a>
                <div class="card-body">
                    <div>
                        <h2><a href="detalles.html?id=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h2>
                        <div class="card-location">${dest.ubicacion}</div>
                        <div class="card-tags-info">${dest.categoria}</div>
                        <p class="card-description">${dest.descripcion}</p>
                    </div>
                    <div class="card-footer">
                        <span class="price-tag">$${dest.precio}</span>
                        <div class="meta-right">
                            <span class="star">⭐ ${dest.rating}</span>
                            <button class="btn-heart" title="Guardar" onclick="toggleHeart(this)">❤️</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        cardsGrid.innerHTML += cardHTML;
    });
}

async function toggleHeart(btn) {
    const card = btn.closest('.card-destino');
    const idDestino = card.querySelector('a').getAttribute('href').split('=')[1];

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
        console.error("Error al guardar favorito:", error);
        btn.classList.toggle('liked');
    }
}

function mostrarError(mensaje) {
    const resultsCount = document.getElementById('resultsCount');
    const cardsGrid = document.getElementById('cardsGrid');
    if (resultsCount) resultsCount.innerText = mensaje;
    if (cardsGrid) cardsGrid.innerHTML = `<p style="grid-column: 1/-1; text-align: center; color: #d9534f;">${mensaje}</p>`;
}
