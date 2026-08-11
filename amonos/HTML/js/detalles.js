
        // FUNCIÓN PRINCIPAL: Enviar costos al planificador mediante URL
        function irAlPlanificador() {
            const destino = "coatepeque";
            const transporte = 10;
            const comida = 12;
            const entradas = 5;
            const extras = 3;

            window.location.href = `planificador.html?destino=${destino}&transporte=${transporte}&comida=${comida}&entradas=${entradas}&extras=${extras}`;
        }

        // Lógica del Carrusel
        let indiceActual = 0;
        const track = document.getElementById('track');
        
        function moverCarrusel(direccion) {
            indiceActual += direccion;
            if (indiceActual > 2) indiceActual = 0;
            if (indiceActual < 0) indiceActual = 2;
            
            track.style.transform = `translateX(-${indiceActual * 33.333}%)`;
        }

        // FUNCIÓN NUEVA: Subir e integrar fotografías dinámicamente
        function agregarFotosComunidad(event) {
            const files = event.target.files;
            const galleryGrid = document.getElementById('userGalleryGrid');

            if (files && files.length > 0) {
                Array.from(files).forEach(file => {
                    const imageUrl = URL.createObjectURL(file);
                    const newImg = document.createElement('img');
                    newImg.src = imageUrl;
                    newImg.className = 'user-gallery-item';
                    newImg.alt = 'Foto subida por usuario';
                    
                    // Insertar al inicio de la galería
                    galleryGrid.insertBefore(newImg, galleryGrid.firstChild);
                });
            }
        }

        // Lógica de Reseñas
        let calificacionSeleccionada = 5;
        const estrellas = document.querySelectorAll('.star-select');

        estrellas.forEach((estrella, index) => {
            estrella.addEventListener('click', () => {
                calificacionSeleccionada = index + 1;
                estrellas.forEach((s, i) => {
                    if (i <= index) {
                        s.classList.add('selected');
                    } else {
                        s.classList.remove('selected');
                    }
                });
            });
        });

        estrellas.forEach(s => s.classList.add('selected'));

        const reviewForm = document.getElementById('reviewForm');
        const commentsContainer = document.getElementById('commentsContainer');

        reviewForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const texto = document.getElementById('reviewText').value;
            const estrellasTexto = '★'.repeat(calificacionSeleccionada) + '☆'.repeat(5 - calificacionSeleccionada);

            const nuevoComentario = document.createElement('div');
            nuevoComentario.className = 'comment-box';
            nuevoComentario.innerHTML = `
                <strong>DIEGO (TÚ):</strong>
                <p>${texto}</p>
                <div class="stars-sub">${estrellasTexto}</div>
            `;

            commentsContainer.appendChild(nuevoComentario);
            document.getElementById('reviewText').value = '';
            alert('¡Gracias! Tu reseña ha sido publicada.');
        });
    