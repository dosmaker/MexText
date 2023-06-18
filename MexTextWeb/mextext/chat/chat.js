document.addEventListener('DOMContentLoaded', function() {
    const messageInput = document.getElementById('messageInput');
    const submitButton = document.getElementById('submitButton');

    document.addEventListener('keydown', function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            submitButton.click();
        }
    });

    submitButton.addEventListener('click', function() {
        // Codice per gestire l'invio del messaggio
        const result = messageInput.value;
        var message = "";
        for (var i = 0; i < result.length; i++) {
            message += result.charAt(i);
            if ((i + 1) % 35 === 0) {
                var lastSpaceIndex = message.lastIndexOf(" ");
                if (lastSpaceIndex !== -1) {
                message = message.substring(0, lastSpaceIndex) + "\n";
                }
            }
        }

        if (message.trim() !== '') {

            // Creazione di un oggetto
            var br = document.createElement("br");
            var oggetto = document.createElement('span');
            oggetto.innerText = message;

            // Aggiunta della classe CSS all'oggetto
            oggetto.classList.add('oval-text');
            oggetto.classList.add('oval-text-right');

            // Recupero del riferimento al div container
            var container = document.getElementById('chat');

            // Aggiunta dell'oggetto come figlio del div container   
            container.appendChild(oggetto);
            container.appendChild(br);

            var elements = document.querySelectorAll(".oval-text");
            if (elements.length > 0) {
                var lastElement = elements[elements.length - 1];
                lastElement.scrollIntoView({ behavior: "smooth", block: "end" });
            }
        }

        var xhr = new XMLHttpRequest();
        // Costruisci la stringa dei parametri da inviare
        var params = "content=" + encodeURIComponent(messageInput.value);
        xhr.open("POST", "sendMessage.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send(params);

        messageInput.value = ''; // Pulisci l'input del messaggio
    });
});