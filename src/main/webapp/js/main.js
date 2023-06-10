$(document).ready(function () {

    const btn = document.getElementById('closeX');
    const modal = document.getElementById('MyModal');

    btn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    };

});

