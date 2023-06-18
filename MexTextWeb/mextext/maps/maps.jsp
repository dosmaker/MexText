<!DOCTYPE html>
<html>
    <head>
        <title>MexTextWeb</title>
        <meta name=”viewport” content=”width=device-width, initial-scale=1.0">
        <link rel='stylesheet' type='text/css' media='screen' href='maps.css'>
        <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    </head>

    <body>
        <%
            if (session.isNew()) {
                response.sendRedirect("../../index.jsp");
            }else{
        %>
        <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>
        <%
                if(request.getParameter("removeCoords") != null && request.getParameter("removeCoords").equals("true")){ SessionDB.removeCoords(); }
                String lat = SessionDB.getLat();
                String lon = SessionDB.getLon();

                if(lat == null || lon == null){
        %>
                    <div style="display: none;">
                        <form action="coordRegistration.jsp" method="post">
                            <input type="text" name="Lat" id="Lat" placeholder="Latitude" required="" autocomplete="off">
                            <input type="text" name="Lon" id="Lon" placeholder="Longitude" required="" autocomplete="off">
                            <button type="submit" id="registration"></button>
                        </form>
                    </div>

                    <div id="mapContainer"> </div>
                    <div class="change"><button onclick="submitMarker()">Submit coords</button></div>
                    <script>
                        var latitude = 41.852764;
                        var longitude = 12.445773;
                        var zoomLevel = 5;
                    </script>
                    <script src="maps.js"></script>

                    <script>
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
                        } else {
                            alert("Select a point on the map");
                        }
                        
                        function successCallback(position) {
                            document.getElementById("Lat").value = position.coords.latitude;
                            document.getElementById("Lon").value = position.coords.longitude;
                            document.getElementById("registration").click();
                        }
                        
                        function errorCallback(error) {
                            alert("Click a point on the map");
                        }

                        var marker;
                        map.on('click', function(e) {
                            if (marker) {
                                map.removeLayer(marker);
                            }
                            marker = L.marker(e.latlng).addTo(map);
                        });

                        function submitMarker(){
                            document.getElementById("Lat").value = marker.getLatLng().lat;
                            document.getElementById("Lon").value = marker.getLatLng().lng;
                            document.getElementById("registration").click();
                        }
                    </script>
        <%
                }else{
        %>
        
        <div id="mapContainer"> </div>
        <script>
            var latitude = "<%=lat%>";
            var longitude = "<%=lon%>";
            var zoomLevel = 10;
        </script>

        <div id="inputKm">
            <label for="selectedValue">Radius km:</label>
            <input type="number" id="selectedValue" placeholder="100.0">
        </div>
        <canvas id="lineCanvas" width="500" height="100"></canvas>
        <script src="maps.js"></script>
        <div id="home">
            <a href="../home/home.jsp"><button>Home</button></a>
        </div>
        <div class="change">
            <button onclick="redirect()">Radius calculation</button>
            <a href="maps.jsp?removeCoords=true"><button>Change your coords</button></a>
        </div>
        <script>
            var radius = new URLSearchParams(window.location.search).get('radius');
            if(radius == null){ radius = 100; }
            var canvasWidth = (radius / 100) * (canvas.width - 100) + 50;
            drawBall(canvasWidth);
            document.getElementById('selectedValue').value = radius;
            var latRadius = radius / 111;
            var lonRadius = radius / (111 * Math.cos(latitude * Math.PI / 180));
        </script>
        <%
                    for(int i = 1; i < Integer.valueOf(SessionDB.getMapsUsers()); i++){
                        float latUser = 0.0f;
                        float lonUser = 0.0f;
                        String latStr = SessionDB.getMapsLat(i);
                        String lonStr = SessionDB.getMapsLon(i);
                        out.println(latStr + " " + lonStr);
                        if (latStr != null && !latStr.trim().isEmpty()) {
                            latUser = Float.parseFloat(latStr);
                        }
                        if (lonStr != null && !lonStr.trim().isEmpty()) {
                            lonUser = Float.parseFloat(lonStr);
                        }
                        String nickUser = SessionDB.getMapsNick(i);

                        
                                    out.println("<script>");
                                    out.println("var latUser = "+latUser+";");
                                    out.println("var lonUser = "+lonUser+";");
                                    out.println("var nickUser = '"+nickUser+"';");
                                    out.println("diffLat = Math.abs(latUser - latitude);");
                                    out.println("diffLon = Math.abs(lonUser - longitude);");
                                    out.println("if(diffLat < latRadius && diffLon < lonRadius){");
                                    out.println("addMarker(latUser, lonUser, nickUser);");
                                    out.println("}");
                                    out.println("</script>");
                    }
                }
            }
        %>
    </body>
</html>