document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById('searchInput');
    const categoryChips = document.querySelectorAll('.chip[data-category]');
    const budgetFilters = document.querySelectorAll('.budget-filter');
    const resetBtn = document.getElementById('resetFilters');

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

    budgetFilters.forEach(filter => {
        filter.addEventListener('change', aplicarFiltros);
    });

    if (resetBtn) {
        resetBtn.addEventListener('click', () => {
            if (searchInput) searchInput.value = "";
            categoryChips.forEach(c => c.classList.remove('active'));
            document.querySelector('.chip[data-category="todos"]').classList.add('active');
            budgetFilters.forEach(f => f.checked = true);
            aplicarFiltros();
        });
    }
});

let destinosBD = [];

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

    const selectedBudgets = Array.from(document.querySelectorAll('.budget-filter:checked')).map(f => f.value);

    const filtrados = destinosBD.filter(dest => {
        const nombre = dest.nombre.toLowerCase();
        const ubicacion = dest.ubicacion.toLowerCase();
        const coincidenTexto = nombre.includes(texto) || ubicacion.includes(texto);

        const coincidenCat = (cat === "todos") || (dest.categoria.toLowerCase() === cat);

        const precio = parseFloat(dest.precio);
        let coincidePresupuesto = true;
        if (selectedBudgets.length < 3) {
            const esEconomico = precio < 20;
            const esConforme = precio >= 20 && precio <= 50;
            const esPremium = precio > 50;

            coincidePresupuesto = (
                (selectedBudgets.includes('economico') && esEconomico) ||
                (selectedBudgets.includes('conforme') && esConforme) ||
                (selectedBudgets.includes('premium') && esPremium)
            );
        }

        return coincidenTexto && coincidenCat && coincidePresupuesto;
    });

    renderizarDestinos(filtrados);
}

function renderizarDestinos(lista) {
    const cardsGrid = document.getElementById('cardsGrid');
    const resultsCount = document.getElementById('resultsCount');

    if (!cardsGrid) return;
    cardsGrid.innerHTML = "";

    if (lista.length === 0) {
        cardsGrid.innerHTML = `<div class="no-results"><i class="fa-solid fa-face-frown"></i><p>No se encontraron destinos que coincidan con tus filtros.</p></div>`;
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
                    <div class="card-main-info">
                        <h2><a href="detalles.html?id=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h2>
                        <div class="card-location"><i class="fa-solid fa-location-dot"></i> ${dest.ubicacion}</div>
                        <div class="card-tags-info"><span class="category-badge">${dest.categoria}</span></div>
                        <p class="card-description">${dest.descripcion}</p>
                    </div>
                    <div class="card-footer">
                        <span class="price-tag">$${parseFloat(dest.precio).toFixed(2)}</span>
                        <div class="meta-right">
                            <span class="star">⭐ ${dest.rating}</span>
                            <button class="btn-heart" title="Guardar" onclick="toggleHeart(this, ${dest.id})">❤️</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        cardsGrid.innerHTML += cardHTML;
    });
}

async function toggleHeart(btn, idDestino) {
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
