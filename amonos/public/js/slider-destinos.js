document.addEventListener('DOMContentLoaded', () => {
    const slider = document.getElementById('destinosSlider');
    const prevBtn = document.getElementById('prevDest');
    const nextBtn = document.getElementById('nextDest');

    if (!slider || !prevBtn || !nextBtn) {
        console.warn("Slider elements not found: ", { slider, prevBtn, nextBtn });
        return;
    }

    const getScrollAmount = () => {
        const card = slider.querySelector('.destino-card');
        if (!card) return 350;
        const style = window.getComputedStyle(slider);
        const gap = parseInt(style.gap) || 0;
        return card.offsetWidth + gap;
    };

    nextBtn.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        slider.scrollBy({
            left: getScrollAmount(),
            behavior: 'smooth'
        });
    });

    prevBtn.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        slider.scrollBy({
            left: -getScrollAmount(),
            behavior: 'smooth'
        });
    });
});