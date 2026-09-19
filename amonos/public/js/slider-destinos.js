document.addEventListener('DOMContentLoaded', () => {
    const slider = document.getElementById('destinosSlider');
    const prevBtn = document.getElementById('prevDest');
    const nextBtn = document.getElementById('nextDest');

    if (!slider || !prevBtn || !nextBtn) return;

    const scrollAmount = 350; // Ancho de la carta + gap

    nextBtn.addEventListener('click', () => {
        slider.scrollBy({
            left: scrollAmount,
            behavior: 'smooth'
        });
    });

    prevBtn.addEventListener('click', () => {
        slider.scrollBy({
            left: -scrollAmount,
            behavior: 'smooth'
        });
    });
});
