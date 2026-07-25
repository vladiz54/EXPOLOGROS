const slides = document.querySelectorAll(".slide");
let index = 0;

function cambiarSlide() {

    // Quitar la clase active del video actual
    slides[index].classList.remove("active");

    // Pausar el video actual
    const videoActual = slides[index].querySelector("video");
    videoActual.pause();

    // Pasar al siguiente slide
    index++;

    if (index >= slides.length) {
        index = 0;
    }

    // Activar el nuevo video
    slides[index].classList.add("active");

    // Reproducir el nuevo video
    const nuevoVideo = slides[index].querySelector("video");
    nuevoVideo.currentTime = 0;
    nuevoVideo.play();
}

// Cambia cada 8 segundos
setInterval(cambiarSlide, 8000);