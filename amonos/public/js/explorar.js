document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById('searchInput');
    const heroSearchInput = document.getElementById('heroSearchInput');
    const categoryChips = document.querySelectorAll('.chip[data-category]');
    const heroChips = document.querySelectorAll('.hero-chip');
    const budgetFilters = document.querySelectorAll('.budget-filter');
    const resetBtn = document.getElementById('resetFilters');

    cargarDestinos();
    initDynamicText();

    if (searchInput) {
        searchInput.addEventListener('input', aplicarFiltros);
    }

    if (heroSearchInput) {
        heroSearchInput.addEventListener('input', (e) => {
            if (searchInput) searchInput.value = e.target.value;
            aplicarFiltros();
        });
    }

    categoryChips.forEach(chip => {
        chip.addEventListener('click', (e) => {
            setActiveChip(e.target.getAttribute('data-category'));
            aplicarFiltros();
        });
    });

    heroChips.forEach(chip => {
        chip.addEventListener('click', (e) => {
            setActiveChip(e.target.getAttribute('data-category'));
            aplicarFiltros();
        });
    });

    budgetFilters.forEach(filter => {
        filter.addEventListener('change', aplicarFiltros);
    });

    if (resetBtn) {
        resetBtn.addEventListener('click', () => {
            if (searchInput) searchInput.value = "";
            if (heroSearchInput) heroSearchInput.value = "";
            setActiveChip('todos');
            budgetFilters.forEach(f => f.checked = true);
            aplicarFiltros();
        });
    }
});

function setActiveChip(category) {
    document.querySelectorAll('.chip[data-category]').forEach(c => {
        c.classList.toggle('active', c.getAttribute('data-category') === category);
    });

    document.querySelectorAll('.hero-chip').forEach(c => {
        c.classList.toggle('active', c.getAttribute('data-category') === category);
    });
}

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

function getRelevantImage(dest) {
    const id = parseInt(dest.id) || 0;
    const imageIndex = (id % 5) + 1;
    return `imagenes/destinos/img${imageIndex}.jpg`;
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
        let imgUrl = "";
        if (dest.imagen && dest.imagen.startsWith('http')) {
            imgUrl = dest.imagen;
        }
        else if (dest.imagen && dest.imagen.trim() !== "") {
            imgUrl = dest.imagen;
        }
        else {
            imgUrl = getRelevantImage(dest);
        }

        const cardHTML = `
            <div class="destino-card">
                <a href="detalles.html?id=${dest.id}" class="dest-img-sim">
                    <img src="${imgUrl}"
                         alt="${dest.nombre}"
                         class="dest-img"
                         onerror="this.src='imagenes/destinos/img1.jpg';">
                    <div class="dest-overlay"></div>
                </a>
                <div class="dest-body">
                    <div>
                        <h4><a href="detalles.html?id=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h4>
                        <p class="dpto">${dest.ubicacion}</p>
                    </div>
                    <div class="dest-footer">
                        <span class="price">$${parseFloat(dest.precio).toFixed(2)}</span>
                        <div class="meta-right">
                            <span class="rating">⭐ ${dest.rating}</span>
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

function initDynamicText() {
    const textElement = document.getElementById('dynamic-text');
    if (!textElement) return;

    const words = ['destino', 'Paraíso', 'Escape', 'Descubrimiento', 'Viaje'];
    let wordIndex = 0;
    let charIndex = 0;
    let isDeleting = false;
    let typeSpeed = 150;

    function type() {
        const currentWord = words[wordIndex];
        const currentText = isDeleting
            ? currentWord.substring(0, charIndex - 1)
            : currentWord.substring(0, charIndex);

        textElement.innerText = currentText;

        if (!isDeleting && charIndex < currentWord.length) {
            charIndex++;
            setTimeout(type, typeSpeed);
        } else if (isDeleting && charIndex > 0) {
            charIndex--;
            setTimeout(type, typeSpeed / 2);
        } else {
            isDeleting = !isDeleting;
            if (!isDeleting) {
                wordIndex = (wordIndex + 1) % words.length;
            }
            setTimeout(type, isDeleting ? 1000 : 500);
        }
    }

    type();
}
