document.addEventListener("DOMContentLoaded", () => {
    const inputPresupuestoMax = document.getElementById('input-presupuesto');
    const selectDestino = document.getElementById('destino-select');
    const qtyInputs = document.querySelectorAll('.qty-input');

    const txtGastado = document.getElementById('txt-gastado');
    const txtLimite = document.getElementById('txt-limite');
    const txtRestante = document.getElementById('txt-restante');
    const txtStatusLabel = document.getElementById('txt-status-label');
    const barraProgreso = document.getElementById('barra-progreso');

    // 1. Initial setup
    inicializarPlanificador();

    // 2. Event Listeners
    inputPresupuestoMax.addEventListener('input', calcularPresupuesto);
    selectDestino.addEventListener('change', handleDestinoChange);
    qtyInputs.forEach(input => {
        input.addEventListener('input', calcularPresupuesto);
    });

    async function inicializarPlanificador() {
        await cargarDestinos();
        cargarDatosDesdeURL();
        calcularPresupuesto();
    }

    async function cargarDestinos() {
        try {
            const response = await fetch('../destinos/read.php');
            const result = await response.json();

            if (result.success) {
                selectDestino.innerHTML = '<option value="Todos">Selecciona un destino...</option>';
                result.data.forEach(dest => {
                    const option = document.createElement('option');
                    option.value = dest.id;
                    option.textContent = dest.nombre;
                    selectDestino.appendChild(option);
                });
            }
        } catch (error) {
            console.error("Error loading destinations:", error);
        }
    }

    async function handleDestinoChange() {
        const idDestino = selectDestino.value;
        if (idDestino === "Todos") return;

        try {
            const response = await fetch(`../destinos/read_one.php?id=${idDestino}`);
            const result = await response.json();

            if (result.success) {
                const costs = result.data.costos;

                // Update fixed unit prices in the UI
                actualizarPrecioFijo('transporte', costs.parqueo);
                actualizarPrecioFijo('comida', costs.comida);
                actualizarPrecioFijo('entradas', costs.entrada);
                actualizarPrecioFijo('extras', 5.00);

                calcularPresupuesto();
            }
        } catch (error) {
            console.error("Error updating costs:", error);
        }
    }

    function actualizarPrecioFijo(id, precio) {
        const unitLabel = document.getElementById(`unit-${id}`);
        const inputQty = document.getElementById(`qty-${id}`);
        if (unitLabel && inputQty) {
            unitLabel.innerText = precio.toFixed(2);
            inputQty.setAttribute('data-unit', precio);
        }
    }

    function cargarDatosDesdeURL() {
        const urlParams = new URLSearchParams(window.location.search);
        const destinoId = urlParams.get('id') || urlParams.get('destino');

        if (destinoId) {
            selectDestino.value = destinoId;
            handleDestinoChange();
        }
    }

    function calcularPresupuesto() {
        const limite = parseFloat(inputPresupuestoMax.value) || 0;
        let totalGastado = 0;

        qtyInputs.forEach(input => {
            const cantidad = parseFloat(input.value) || 0;
            const precioUnitario = parseFloat(input.getAttribute('data-unit')) || 0;
            const subtotal = cantidad * precioUnitario;

            const subtotalSpan = input.nextElementSibling;
            if (subtotalSpan && subtotalSpan.classList.contains('subtotal')) {
                subtotalSpan.innerText = `$${subtotal.toFixed(2)}`;
            }

            totalGastado += subtotal;
        });

        const restante = limite - totalGastado;
        const porcentaje = limite > 0 ? (totalGastado / limite) * 100 : 0;

        txtLimite.innerText = `$${limite.toFixed(2)}`;
        txtGastado.innerText = `$${totalGastado.toFixed(2)}`;
        txtRestante.innerText = `$${Math.abs(restante).toFixed(2)}`;

        if (restante >= 0) {
            txtRestante.style.color = 'var(--primary-color)';
            txtStatusLabel.innerText = "DISPONIBLE";
            txtStatusLabel.style.color = 'var(--text-muted)';
            barraProgreso.style.backgroundColor = 'var(--primary-color)';
            barraProgreso.style.width = `${Math.min(porcentaje, 100)}%`;
        } else {
            txtRestante.style.color = 'var(--alert-color)';
            txtStatusLabel.innerText = "EXCEDIDO";
            txtStatusLabel.style.color = 'var(--alert-color)';
            barraProgreso.style.backgroundColor = 'var(--alert-color)';
            barraProgreso.style.width = '100%';
        }
    }
});
