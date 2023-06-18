<!DOCTYPE html>
<html>
    <head>
        <title>MexTextWeb</title>
        <meta name=”viewport” content=”width=device-width, initial-scale=1.0">
        <link rel='stylesheet' type='text/css' media='screen' href='home.css'>
    </head>
    <body>
        <%
            if (session.isNew()) {
                response.sendRedirect("../../index.jsp");
            }
        %>
        
        <h1>Welcome in MexTextWeb</h1>
        <div id="buttons">
            <a href="../maps/maps.jsp"><button>Find people nearby</button></a>
            <a href="../chat/chat.jsp"><button>Access to chats</button></a>
        </div>
        <div id="buttons2">
            <a href="../../index.jsp"><button>Logout</button></a>
        </div>
    </body>
</html>