document.addEventListener('DOMContentLoaded', () => {
    cargarDatosPerfil();
    cargarFavoritosPerfil();

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

    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            await guardarPerfil();
        });
    }
});

async function cargarDatosPerfil() {
    try {
        const response = await fetch('../auth/read_profile.php');
        const result = await response.json();
        if (result.success) {
            const user = result.data;
            document.getElementById('userNameDisplay').innerText = user.nombre;
            document.getElementById('modal-name').value = user.nombre;
            document.getElementById('modal-email').value = user.correo;
        }
    } catch (error) {
        console.error('Error cargando perfil:', error);
    }
}

async function guardarPerfil() {
    const nombre = document.getElementById('modal-name').value.trim();
    const correo = document.getElementById('modal-email').value.trim();

    try {
        const response = await fetch('../auth/update_profile.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ nombre, correo })
        });
        const result = await response.json();
        if (result.success) {
            document.getElementById('userNameDisplay').innerText = nombre;
            document.getElementById('editProfileModal').classList.remove('active');
            alert("Perfil actualizado");
        } else {
            alert(result.message);
        }
    } catch (error) {
        console.error('Error guardando perfil:', error);
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
                container.innerHTML = `<p style="font-size: 13px; color: #64748b; text-align: center; padding: 15px 0;">Aún no tienes favoritos.</p>`;
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
    if (!confirm("¿Eliminar este destino de tus favoritos?")) return;
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
