document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById('searchInput');
    const heroSearchInput = document.getElementById('heroSearchInput');
    const categoryChips = document.querySelectorAll('.chip[data-category]');
    const heroChips = document.querySelectorAll('.hero-chip');
    const budgetFilters = document.querySelectorAll('.budget-filter');
    const resetBtn = document.getElementById('resetFilters');

    // --- CUSTOM SELECT LOGIC ---
    const selectTrigger = document.querySelector('.custom-select-trigger');
    const selectWrapper = document.querySelector('.custom-select-wrapper');
    const customOptions = document.querySelectorAll('.custom-option');
    const selectedSortText = document.getElementById('selected-sort');

    if (selectTrigger) {
        selectTrigger.addEventListener('click', () => {
            selectWrapper.classList.toggle('open');
        });
    }

    customOptions.forEach(option => {
        option.addEventListener('click', () => {
            const value = option.getAttribute('data-value');
            const text = option.innerText;

            selectedSortText.innerText = text;
            selectWrapper.classList.remove('open');

            // Trigger a custom event or call sorting logic
            // For now, we simulate a sort by re-applying filters (in a real app, you'd have a sort function)
            aplicarFiltros(value);
        });
    });

    // Close dropdown when clicking outside
    window.addEventListener('click', (e) => {
        if (selectWrapper && !selectWrapper.contains(e.target)) {
            selectWrapper.classList.remove('open');
        }
    });
    // -----------------------------

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

    // --- SURPRISE ME LOGIC ---
    const btnSurpriseMe = document.getElementById('btnSurpriseMe');
    if (btnSurpriseMe) {
        btnSurpriseMe.addEventListener('click', () => {
            if (destinosBD.length === 0) {
                alert("¡Primero debemos cargar los destinos!");
                return;
            }
            const randomDest = destinosBD[Math.floor(Math.random() * destinosBD.length)];
            window.location.href = `detalles.html?id=${randomDest.id}`;
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

    if (resultsCount) resultsCount.innerText = "Loading destinations...";

    try {
        const response = await fetch('../destinos/read.php');
        if (!response.ok) throw new Error(`Error HTTP: ${response.status}`);

        const result = await response.json();
        if (result.success) {
            destinosBD = result.data;
            aplicarFiltros();
        } else {
            mostrarError(result.message || "Error loading destinations");
        }
    } catch (error) {
        console.error("Fetch Error:", error);
        mostrarError("Could not connect to the server.");
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
        cardsGrid.innerHTML = `<div class="no-results"><i class="fa-solid fa-face-frown"></i><p>No destinations found matching your filters.</p></div>`;
        if (resultsCount) resultsCount.innerText = "0 results found";
        return;
    }

    if (resultsCount) {
        // Lógica de mensajes dinámicos según la cantidad
        let label = "Destinos";
        if (lista.length === 1) label = "joya oculta";
        else if (lista.length < 10) label = "joyas ocultas";
        else label = "destinos";

        // Animación de contador numérica
        const targetNumber = lista.length;

        resultsCount.innerHTML = `
            <span class="results-text-label">Encontramos</span>
            <span class="results-number-highlight">${targetNumber}</span>
            <span class="results-text-destinos">${label}</span>
        `;
    }

    lista.forEach((dest, index) => {
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
            <div class="destino-card" style="animation: cardEntrance 0.6s cubic-bezier(0.23, 1, 0.32, 1) forwards; animation-delay: ${index * 0.05}s; opacity: 0;">
                <a href="detalles.html?id=${dest.id}" class="card-link-wrapper">
                    <div class="dest-img-container">
                        <span class="dest-badge">${dest.categoria || 'Destination'}</span>
                        <div class="dest-img-sim" style="background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${imgUrl}') center/cover; height: 230px;"></div>
                    </div>
                    <div class="dest-body">
                        <div class="dest-info">
                            <h4>${dest.nombre}</h4>
                            <p class="dpto">${dest.ubicacion}</p>
                            <p class="dest-short-desc">${dest.descripcion ? (dest.descripcion.length > 70 ? dest.descripcion.substring(0, 67) + '...' : dest.descripcion) : "Discover this incredible destination and live an unforgettable experience."}</p>
                        </div>
                        <div class="dest-footer">
                            <span class="price">$${parseFloat(dest.precio || 0).toFixed(2)}</span>
                            <div class="meta-right">
                                <span class="rating">⭐ ${dest.rating || '0.0'}</span>
                                <button class="btn-heart" data-id="${dest.id}" title="Save" onclick="toggleHeart(event, this)">❤️</button>
                            </div>
                        </div>
                    </div>
                </a>
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

    const words = ['destination', 'Paradise', 'Escape', 'Discovery', 'Trip'];
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
