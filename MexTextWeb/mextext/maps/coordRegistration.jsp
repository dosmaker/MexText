<!DOCTYPE html>
<html>
    <head>
        <title>MexTextWeb</title>
        <meta name=”viewport” content=”width=device-width, initial-scale=1.0">
        <link rel='stylesheet' type='text/css' media='screen' href='insert.css'>
    </head>
    <body>
        <%
            if (session.isNew()) {
                response.sendRedirect("../../index.jsp");
            }else{
        %>
        
        <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>
        <jsp:setProperty name="SessionDB" property="lat" value='<%=request.getParameter("Lat")%>'/>
        <jsp:setProperty name="SessionDB" property="lon" value='<%=request.getParameter("Lon")%>'/>

        <%response.sendRedirect("maps.jsp");}%>
    </body>
</html>