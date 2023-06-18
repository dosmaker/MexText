var map = L.map(document.getElementById("mapContainer")).setView([latitude, longitude], zoomLevel);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors',
  maxZoom: 30,
}).addTo(map);

function addMarker(lat, lon, nick){
    L.marker([lat, lon]).addTo(map)
    .bindPopup(''+nick)
    .openPopup();
}


var canvas = document.getElementById('lineCanvas');
    var ctx = canvas.getContext('2d');
    var ctx1 = canvas.getContext('2d');
    var ballRadius = 10; // Raggio della pallina

    // Disegna la linea sull'area di disegno
    ctx.beginPath();
    ctx.moveTo(50, 50);
    ctx.lineTo(450, 50);
    ctx.strokeStyle = 'grey';
    ctx.lineWidth = 3;
    ctx.stroke();

    // Disegna la pallina sulla linea
    function drawBall(x) {
      ctx1.beginPath();
      ctx1.arc(x, 50, ballRadius, 0, Math.PI * 2);
      ctx1.fillStyle = 'red';
      ctx1.fill();
      ctx1.closePath();
    }

    // Gestisci l'evento di click sulla linea
    canvas.addEventListener('click', function(event) {
        var rect = canvas.getBoundingClientRect();
        var mouseX = event.clientX - rect.left;
        if(mouseX >= 50 && mouseX <= 450){
            var percent = (mouseX - 50) / (canvas.width - 100);
            var value = percent * 100; // Valore compreso tra 0 e 100
            document.getElementById('selectedValue').value = value.toFixed(2);

            // Cancella il canvas e ridisegna la pallina
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.beginPath();
            ctx.moveTo(50, 50);
            ctx.lineTo(450, 50);
            ctx.strokeStyle = 'grey';
            ctx.lineWidth = 3;
            ctx.stroke();
            drawBall(mouseX);
        }
    });

    // Disegna la pallina iniziale
    addMarker(latitude, longitude, "You");

function redirect(){
    var radius = document.getElementById('selectedValue').value;
    window.location.href = "maps.jsp?radius="+radius+"";
}