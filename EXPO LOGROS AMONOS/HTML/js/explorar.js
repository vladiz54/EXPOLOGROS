
    // Configuración y variables globales
    const API_URL = 'read.php'; // Ruta a tu script PHP
    let destinosBD = []; // Guardará los datos remotos en memoria
    let categoriaSeleccionada = "todos";

    // Referencias al DOM
    const cardsGrid = document.getElementById('cardsGrid');
    const resultsCount = document.getElementById('resultsCount');
    const searchInput = document.getElementById('searchInput');

    // 1. CARGAR DATOS DESDE EL BACKEND (PHP / MySQL)
    async function cargarDestinos() {
        resultsCount.innerText = "Cargando destinos desde la base de datos...";
        
        try {
            const respuesta = await fetch(API_URL);
            const resultado = await respuesta.json();

            if (resultado.status === 'success') {
                destinosBD = resultado.data;
                aplicarFiltros();
            } else {
                mostrarError("Ocurrió un error al cargar la información.");
                console.error(resultado.message);
            }
        } catch (error) {
            mostrarError("No se pudo conectar con el servidor.");
            console.error("Error Fetch:", error);
        }
    }

    // 2. RENDERIZAR TARJETAS EN EL DOM
    function renderizarDestinos(lista) {
        cardsGrid.innerHTML = "";

        if (lista.length === 0) {
            cardsGrid.innerHTML = `<p style="grid-column: 1/-1; text-align: center; color: #666; padding: 20px;">No se encontraron destinos con los filtros seleccionados.</p>`;
            resultsCount.innerText = "No hay resultados para esta búsqueda.";
            return;
        }

        resultsCount.innerText = `Se encontraron ${lista.length} destinos sugeridos para tus filtros`;

        lista.forEach(dest => {
            const cardHTML = `
                <div class="card-destino">
                    <a href="detalles.html?destino=${dest.id}" 
                       class="card-img-sim" 
                       style="display: block; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${dest.imagen}') center/cover;">
                    </a>
                    <div class="card-body">
                        <div>
                            <h2><a href="detalles.html?destino=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h2>
                            <div class="card-location">${dest.ubicacion}</div>
                            <div class="card-tags-info">${dest.tags}</div>
                            <p class="card-description">${dest.descripcion}</p>
                        </div>
                        <div class="card-footer">
                            <span class="price-tag">${dest.precioTexto}</span>
                            <div class="meta-right">
                                <span class="star">${dest.rating}</span>
                                <button class="btn-heart" title="Guardar" onclick="toggleHeart(this)">❤️</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            cardsGrid.innerHTML += cardHTML;
        });
    }

    // 3. APLICAR FILTROS LOCALES SOBRE LA DATA
    function aplicarFiltros() {
        const textoBusqueda = searchInput.value.toLowerCase().trim();

        const resultados = destinosBD.filter(dest => {
            const coincideTexto = dest.nombre.toLowerCase().includes(textoBusqueda) || 
                                  dest.ubicacion.toLowerCase().includes(textoBusqueda);

            const coincideCategoria = (categoriaSeleccionada === "todos") || 
                                       (dest.categoria === categoriaSeleccionada);

            return coincideTexto && coincideCategoria;
        });

        renderizarDestinos(resultados);
    }

    // 4. INTERACTIVIDAD DE LOS CHIPS
    document.querySelectorAll('.chips-flex').forEach(container => {
        container.addEventListener('click', (e) => {
            if (e.target.classList.contains('chip')) {
                const parent = e.target.parentElement;
                
                if (parent.id === "categoryChips") {
                    parent.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
                    e.target.classList.add('active');
                    categoriaSeleccionada = e.target.getAttribute('data-category').toLowerCase();
                    aplicarFiltros();
                } else {
                    e.target.classList.toggle('active');
                }
            }
        });
    });

    // Escuchar la barra de búsqueda en tiempo real
    searchInput.addEventListener('input', aplicarFiltros);

    // Botón de me gusta
    function toggleHeart(btn) {
        btn.classList.toggle('liked');
        btn.style.transform = "scale(1.3)";
        setTimeout(() => btn.style.transform = "scale(1)", 150);
    }

    // Mensaje de error genérico
    function mostrarError(mensaje) {
        resultsCount.innerText = mensaje;
        cardsGrid.innerHTML = `<p style="grid-column: 1/-1; text-align: center; color: #d9534f; padding: 20px;">${mensaje}</p>`;
    }

    // Carga inicial al cargar el DOM
    window.addEventListener('DOMContentLoaded', cargarDestinos);


/*

    // 1. BASE DE DATOS LOCAL EN JAVASCRIPT (MVP)
    const destinos = [
        {
            id: "boqueron",
            nombre: "El Boquerón",
            ubicacion: "San Salvador — Parque Nacional",
            tags: "Familias / Senderistas",
            descripcion: "Camina alrededor del cráter gigante y disfruta de vistas impresionantes de la capital salvadoreña en un clima fresco.",
            precioTexto: "$10 - $25",
            rating: "⭐ 4.7",
            imagen: "https://diarioelsalvador.com/wp-content/uploads/2023/09/F5R5MfEWoAEAKwQ.jpg",
            categoria: "aventura",
            presupuesto: "economico"
        },
        {
            id: "jardin",
            nombre: "Jardín Botánico",
            ubicacion: "La Libertad — Antiguo Cuscatlán",
            tags: "Familias / Estudiantes",
            descripcion: "Un oasis de naturaleza y biodiversidad resguardado en el fondo de un cráter volcánico extinto.",
            precioTexto: "$5 - $10",
            rating: "⭐ 4.6",
            imagen: "https://wallpaperbat.com/img/366872-wallpaper-flowers-garden-trees-the-bushes-botanic-gardens.jpg",
            categoria: "cultural",
            presupuesto: "economico"
        },
        {
            id: "surfcity",
            nombre: "SurfCity",
            ubicacion: "La Libertad — Costa",
            tags: "Familias / Surfistas",
            descripcion: "Olas perfectas para practicar surf, espectaculares atardeceres de ensueño, gastronomía marina y pura buena vibra.",
            precioTexto: "$25 - $120",
            rating: "⭐ 4.6",
            imagen: "https://elsalvadoravanza.com/wp-content/uploads/2024/05/Gob.jpeg",
            categoria: "playa",
            presupuesto: "conforme"
        },
        {
            id: "coatepeque",
            nombre: "Lago de Coatepeque",
            ubicacion: "Santa Ana",
            tags: "Amigos / Familias",
            descripcion: "Disfruta de deportes acuáticos, paseos en lancha y la gastronomía local con vista al lago volcánico.",
            precioTexto: "$15 - $40",
            rating: "⭐ 4.8",
            imagen: "https://www.meteorologiaenred.com/wp-content/uploads/2024/03/el-lago-coatepeque-1024x768.jpg.webp",
            categoria: "aventura",
            presupuesto: "conforme"
        },
        {
            id: "flores",
            nombre: "Ruta de las Flores",
            ubicacion: "Ahuachapán / Sonsonate",
            tags: "Turistas / Parejas",
            descripcion: "Pueblos pintorescos, gastronomía tradicional, cafés de altura y clima de montaña inigualable.",
            precioTexto: "$20 - $60",
            rating: "⭐ 4.9",
            imagen: "https://diarioelsalvador.com/wp-content/uploads/2023/09/F5R5MfEWoAEAKwQ.jpg",
            categoria: "gastronomico",
            presupuesto: "conforme"
        }
    ];

    // REFERENCIAS AL DOM
    const cardsGrid = document.getElementById('cardsGrid');
    const resultsCount = document.getElementById('resultsCount');
    const searchInput = document.getElementById('searchInput');

    let categoriaSeleccionada = "todos";

    // 2. FUNCIÓN PARA MOSTRAR LAS TARJETAS EN PANTALLA
    function renderizarDestinos(lista) {
        cardsGrid.innerHTML = "";

        if (lista.length === 0) {
            cardsGrid.innerHTML = `<p style="grid-column: 1/-1; text-align: center; color: #666;">No se encontraron destinos con los filtros seleccionados.</p>`;
            resultsCount.innerText = "No hay resultados para esta búsqueda.";
            return;
        }

        resultsCount.innerText = `Se encontraron ${lista.length} destinos sugeridos para tus filtros`;

        lista.forEach(dest => {
            const cardHTML = `
                <div class="card-destino">
                    <a href="detalles.html?destino=${dest.id}" 
                       class="card-img-sim" 
                       style="display: block; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), url('${dest.imagen}') center/cover;">
                    </a>
                    <div class="card-body">
                        <div>
                            <h2><a href="detalles.html?destino=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h2>
                            <div class="card-location">${dest.ubicacion}</div>
                            <div class="card-tags-info">${dest.tags}</div>
                            <p class="card-description">${dest.descripcion}</p>
                        </div>
                        <div class="card-footer">
                            <span class="price-tag">${dest.precioTexto}</span>
                            <div class="meta-right">
                                <span class="star">${dest.rating}</span>
                                <button class="btn-heart" title="Guardar" onclick="toggleHeart(this)">❤️</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            cardsGrid.innerHTML += cardHTML;
        });
    }

    // 3. FUNCIÓN PRINCIPAL DE FILTRADO
    function aplicarFiltros() {
        const textoBusqueda = searchInput.value.toLowerCase().trim();

        const resultados = destinos.filter(dest => {
            // Filtro por texto
            const coincideTexto = dest.nombre.toLowerCase().includes(textoBusqueda) || 
                                  dest.ubicacion.toLowerCase().includes(textoBusqueda);

            // Filtro por categoría
            const coincideCategoria = (categoriaSeleccionada === "todos") || (dest.categoria === categoriaSeleccionada);

            return coincideTexto && coincideCategoria;
        });

        renderizarDestinos(resultados);
    }

    // 4. INTERACTIVIDAD EN LOS CHIPS (CAMBIO DE COLOR Y SELECCIÓN)
    document.querySelectorAll('.chips-flex').forEach(container => {
        container.addEventListener('click', (e) => {
            if (e.target.classList.contains('chip')) {
                // Alternar clase active en el grupo actual
                const parent = e.target.parentElement;
                
                // Si es el grupo de categorías, registramos la categoría seleccionada
                if (parent.id === "categoryChips") {
                    parent.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
                    e.target.classList.add('active');
                    categoriaSeleccionada = e.target.getAttribute('data-category');
                    aplicarFiltros();
                } else {
                    // Para otros grupos (multiselección visual)
                    e.target.classList.toggle('active');
                }
            }
        });
    });

    // Escuchar la barra de búsqueda en tiempo real
    searchInput.addEventListener('input', aplicarFiltros);

    // Botón de me gusta (corazón interactivo)
    function toggleHeart(btn) {
        btn.classList.toggle('liked');
        btn.style.transform = "scale(1.3)";
        setTimeout(() => btn.style.transform = "scale(1)", 150);
    }

    // Carga inicial al abrir la página
    window.addEventListener('DOMContentLoaded', () => {
        aplicarFiltros();
    });

    */