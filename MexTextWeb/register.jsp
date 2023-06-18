<!DOCTYPE html>
<html>
<head>
    <title>MexTextWeb</title>
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
    <jsp:useBean id="SessionDB" class="mieiBean.MexTextDB"/>

	<jsp:setProperty name="SessionDB" property="nickname" value="<%=request.getParameter(\"txt\")%>"/>
    <jsp:setProperty name="SessionDB" property="email" value="<%=request.getParameter(\"email\")%>"/>
	<jsp:setProperty name="SessionDB" property="password" value="<%=request.getParameter(\"pswd\")%>"/>
    <label id="registerBool" style="display: none;"><jsp:getProperty name="SessionDB" property="register"/></label>
    <script>
        if(document.getElementById("registerBool").innerText == "false"){
            alert("Nickname or Email already in use!");
            window.location.replace("index.jsp");
        }else{
            window.location.replace("index.jsp");
        }
    </script>
</body>
</html>