document.addEventListener('DOMContentLoaded', () => {
    cargarDatosPerfil();
    cargarFavoritosPerfil();
    cargarVisitadosPerfil();

    const openBtn = document.getElementById('openModalBtn');
    const closeBtn = document.getElementById('closeModalBtn');
    const modal = document.getElementById('editProfileModal');
    const form = document.getElementById('editProfileForm');

    if (openBtn) openBtn.addEventListener('click', () => modal.classList.add('active'));
    if (closeBtn) closeBtn.addEventListener('click', () => modal.classList.remove('active'));
    if (modal) {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) modal.classList.remove('active');
        });
    }

    // Manejo de subida de imagen de perfil
    const avatarInput = document.getElementById('modal-avatar-input');
    const avatarPreview = document.getElementById('modal-avatar-preview');

    if (avatarInput && avatarPreview) {
        avatarInput.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    avatarPreview.style.backgroundImage = `url('${e.target.result}')`;
                    avatarPreview.style.backgroundSize = 'cover';
                    avatarPreview.style.backgroundPosition = 'center';
                    avatarPreview.textContent = ''; // Quitar la letra inicial
                };
                reader.readAsDataURL(file);
            }
        });
    }

    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            await guardarPerfil();
        });
    }

    // Manejo de Cerrar Sesión
    const logoutLink = document.querySelector('.logout-link');
    if (logoutLink) {
        logoutLink.addEventListener('click', async (e) => {
            e.preventDefault();
            if (confirm('Are you sure you want to log out?')) {
                try {
                    const response = await fetch('../auth/logout.php');
                    const result = await response.json();
                    if (result.success) {
                        window.location.href = 'sesion.html';
                    } else {
                        alert('Error logging out: ' + result.message);
                    }
                } catch (error) {
                    console.error('Error in logout:', error);
                    alert('An error occurred while trying to log out.');
                }
            }
        });
    }
});

async function cargarDatosPerfil() {
    try {
        const response = await fetch('../auth/read_profile.php');
        if (response.status === 401) {
            window.location.href = 'sesion.html';
            return;
        }
        const result = await response.json();
        if (result.success) {
            const user = result.data;
            document.getElementById('userNameDisplay').innerText = user.nombre;
            document.getElementById('modal-name').value = user.nombre;
            document.getElementById('modal-email').value = user.correo;

            // Si el usuario ya tiene una foto guardada (simulado), cargarla
            if (user.foto_perfil) {
                const avatarBig = document.querySelector('.profile-avatar-big');
                const avatarModal = document.getElementById('modal-avatar-preview');
                if (avatarBig) {
                    avatarBig.style.backgroundImage = `url('${user.foto_perfil}')`;
                    avatarBig.style.backgroundSize = 'cover';
                    avatarBig.style.backgroundPosition = 'center';
                    avatarBig.textContent = '';
                }
                if (avatarModal) {
                    avatarModal.style.backgroundImage = `url('${user.foto_perfil}')`;
                    avatarModal.style.backgroundSize = 'cover';
                    avatarModal.style.backgroundPosition = 'center';
                    avatarModal.textContent = '';
                }
            }
        } else {
            window.location.href = 'sesion.html';
        }
    } catch (error) {
        console.error('Error cargando perfil:', error);
        window.location.href = 'sesion.html';
    }
}

async function guardarPerfil() {
    const nombre = document.getElementById('modal-name').value.trim();
    const correo = document.getElementById('modal-email').value.trim();
    const avatarInput = document.getElementById('modal-avatar-input');

    const formData = new FormData();
    formData.append('nombre', nombre);
    formData.append('correo', correo);

    if (avatarInput && avatarInput.files[0]) {
        formData.append('foto', avatarInput.files[0]);
    }

    try {
        const response = await fetch('../auth/update_profile.php', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();
        if (result.success) {
            document.getElementById('userNameDisplay').innerText = nombre;
            document.getElementById('editProfileModal').classList.remove('active');
            alert("Profile updated");
            cargarDatosPerfil();
        } else {
            alert(result.message);
        }
    } catch (error) {
        console.error('Error guardando perfil:', error);
    }
}

async function cargarVisitadosPerfil() {
    const container = document.getElementById('visitedPlacesContainer');
    if (!container) return;

    try {
        const response = await fetch('../visitados/read_visits.php');
        const result = await response.json();
        if (result.success) {
            const visitados = result.data;
            if (visitados.length === 0) {
                container.innerHTML = `<p style="font-size: 13px; color: #64748b; text-align: center; padding: 15px 0;">You haven't saved any visits in your history yet.</p>`;
                return;
            }
            container.innerHTML = visitados.map(dest => `
                <div class="profile-item-row">
                    <div class="item-thumb" style="background: linear-gradient(135deg, var(--coral-marca), #f97316)"></div>
                    <div class="item-info">
                        <h4>${dest.nombre}</h4>
                        <p>Total spent: <b>$${parseFloat(dest.total).toFixed(2)}</b></p>
                    </div>
                    <span class="item-meta-badge badge-history">Visited</span>
                </div>
            `).join('');
        }
    } catch (error) {
        console.error('Error cargando visitados:', error);
    }
}

async function cargarFavoritosPerfil() {
    const container = document.getElementById('savedItemsContainer');
    if (!container) return;

    try {
        const response = await fetch('../favoritos/read.php');
        const result = await response.json();
        if (result.success) {
            const favoritos = result.data;
            if (favoritos.length === 0) {
                container.innerHTML = `<p style="font-size: 13px; color: #64748b; text-align: center; padding: 15px 0;">You have no favorites yet.</p>`;
                return;
            }
            container.innerHTML = favoritos.map(dest => `
                <div class="profile-item-row" id="fav-item-${dest.id}">
                    <div class="item-thumb" style="background: url('${dest.imagen}') center/cover;"></div>
                    <div class="item-info">
                        <h4><a href="detalles.html?id=${dest.id}" style="text-decoration: none; color: inherit;">${dest.nombre}</a></h4>
                        <p>${dest.departamento}</p>
                    </div>
                    <button class="btn-delete-item" onclick="eliminarFavorito(${dest.id})" title="Eliminar">🗑️</button>
                </div>
            `).join('');
        }
    } catch (error) {
        console.error('Error cargando favoritos:', error);
    }
}

async function eliminarFavorito(id) {
    if (!confirm("Delete this destination from your favorites?")) return;
    try {
        const response = await fetch('../favoritos/toggle.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id_destino: id })
        });
        const result = await response.json();
        if (result.success) {
            cargarFavoritosPerfil();
        }
    } catch (error) {
        console.error('Error eliminando favorito:', error);
    }
}
