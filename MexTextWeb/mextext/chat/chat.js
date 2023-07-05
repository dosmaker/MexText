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
        var currentLine = "";
        var word = "";
        
        for (var i = 0; i < result.length; i++) {
            var currentChar = result.charAt(i);
        
            if (currentChar === " " || currentChar === "\n") {
                if (currentChar === "\n") {
                    // Se il carattere corrente è un a capo, aggiungo il rigo corrente a `message`
                    message += currentLine.trim() + "\n";
                    currentLine = "";
                }else{
                    if (currentLine.length + word.length > 35) {
                        // Aggiungo una nuova riga prima della parola corrente solo se supera il limite di lunghezza del rigo corrente
                        message += currentLine.trim() + "\n";
                        currentLine = "";
                    }
            
                    currentLine += word + currentChar;
                    word = "";
                }
            } else {
                word += currentChar;

                if(word.length == 34){
                    currentLine += word + "-";
                    message += currentLine.trim() + "\n";
                    currentLine = "";
                    word = "";
                }
        
                if ((i + 1) % 35 === 0 || i === result.length - 1) {
                    if (currentLine.length + word.length > 35) {
                        // Aggiungo una nuova riga prima della parola corrente solo se supera il limite di lunghezza del rigo corrente
                        message += currentLine.trim() + "\n";
                        currentLine = "";
                    }
                }
            }
        }
        
        if (currentLine.trim() !== '') {
            message += currentLine.trim();
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

        var mex = "";
        for (var i = 0; i < result.length; i++) {
            var c = result.charAt(i);
            
            if (c === '"' || c === '\'') {
              mex += '\\';
            }
            
            mex += c;
          }

        var xhr = new XMLHttpRequest();
        // Costruisci la stringa dei parametri da inviare
        var params = "content=" + encodeURIComponent(mex);
        xhr.open("POST", "sendMessage.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send(params);

        messageInput.value = ''; // Pulisci l'input del messaggio
    });
});