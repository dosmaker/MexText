<!DOCTYPE html>
<html>
    <head>
        <title>MexTextWeb</title>
        <meta name=”viewport” content=”width=device-width, initial-scale=1.0">
    </head>
    <style>
        body{
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            font-family: 'Jost', sans-serif;
            background: linear-gradient(to bottom, #29160c, #633f2b, #3e3024);
        }
    </style>
    <body>
        <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>

        <jsp:setProperty name="SessionDB" property="nickname" value='<%=request.getParameter("loginTxt")%>'/>
        <jsp:setProperty name="SessionDB" property="password" value='<%=request.getParameter("loginPswd")%>'/>
        <%
            if(SessionDB.Login()){
                session.setMaxInactiveInterval(600);
                response.sendRedirect("home/home.jsp");
            }else{
                out.println("<script>");
                out.println("alert('Nickname or password invalid');");
                out.println("window.location.replace('../index.jsp');");
                out.println("</script>");
            }
        %>
    </body>
</html>