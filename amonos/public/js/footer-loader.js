document.addEventListener('DOMContentLoaded', () => {
    const footerContainer = document.createElement('div');
    footerContainer.id = 'global-footer-root';
    document.body.appendChild(footerContainer);

    fetch('footer.html')
        .then(response => response.text())
        .then(data => {
            footerContainer.innerHTML = data;
        })
        .catch(error => console.error('Error loading footer:', error));
});