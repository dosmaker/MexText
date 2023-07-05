<!DOCTYPE html>
<html>
<head>
  <title>Chat Page</title>
  <link rel='stylesheet' type='text/css' media='screen' href='chat.css'>
  <script src="chat.js"></script>
</head>
<body>
  <%
      if (session.isNew()) {
          response.sendRedirect("../../index.jsp");
      }
  %>
  <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>   
  <%
      //SessionDB.online();
      if(request.getParameter("nameInput") != null){
        %>
        <jsp:setProperty name="SessionDB" property="nicknameChat" value='<%=request.getParameter("nameInput")%>'/>
          <script>
            function updateChat() {
              var xhttp = new XMLHttpRequest();
              xhttp.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                  var response = this.responseText.trim();
                  const result = response;
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
                  
                  // Aggiorna la visualizzazione dei messaggi sulla pagina
                  if (response !== "null") {
                      var br = document.createElement("br");
                      var oggetto = document.createElement('span');
                      oggetto.innerText = message;
                      oggetto.classList.add('oval-text');
                      oggetto.classList.add('oval-text-left');
    
                      var container = document.getElementById('chat');   
                      container.appendChild(oggetto);
                      container.appendChild(br);
    
                      var elements = document.querySelectorAll(".oval-text");
                      if (elements.length > 0) {
                          var lastElement = elements[elements.length - 1];
                          lastElement.scrollIntoView({ behavior: "smooth", block: "end" });
                      }
                    }
                }
              };
              xhttp.open("GET", "updateChat.jsp", true);
              xhttp.send();
            }
          
            // Aggiorna la chat ogni 5 secondi
            setInterval(updateChat, 1000);
          </script>
        <%
      }
  %>

  <div class="sidebar">
    <h2 id="colorful-text">MexTextWeb</h2>
    <script>
        function changeTextColor() {
          const colorfulText = document.getElementById('colorful-text');
          const randomColor = getRandomColor();
          colorfulText.style.color = randomColor;
        }
    
        function getRandomColor() {
          const letters = '0123456789ABCDEF';
          let color = '#';
          for (let i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
          }
          return color;
        }
    
        setInterval(changeTextColor, 500); // Cambia il colore del testo ogni secondo
      </script>
    <form action="chat.jsp" method="post">
      <center><input type="text" id="nameInput" name="nameInput" placeholder="Nickname"></center>
      <input id="buttonNewChat" type="submit" value="New Chat">
    </form>
    <h2>
      <%
        out.print(SessionDB.getNicknameChat());
      %>
    </h2>
  </div>

  <div class="chat-container">
    <h2>Chat</h2>
    <div class="chat-messages" id="chat">
         
    </div>
    <div class="chat-input">
      <input type="text" id="messageInput" placeholder="Inserisci il tuo messaggio">
      <input type="submit" id="submitButton" value="Invia">
    </div>
  </div>
</body>
</html>