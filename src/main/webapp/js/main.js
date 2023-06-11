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

$(document).ready(function() {
        // Handle click event on "Bloquear" button in the first modal
        $("#bloquearButton").click(function() {
            // Get the selected campus value
            var campusId = $("#campus-campusId").val();

            // Set the value of the hidden input field in the second modal
            $("#campusId" + campusId).val(campusId);

            // Open the second modal
            $("#modalBloqueio" + campusId).modal("show");
        });
    });