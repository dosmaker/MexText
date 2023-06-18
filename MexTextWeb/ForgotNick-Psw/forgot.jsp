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
        background: linear-gradient(to bottom, #290c0c, #632b2b, #3e2424);
    }
</style>
<body>
    <h1>Check your Email Inbox and Spam folder!</h1>

    <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>

	<%SessionDB.sendEmail(request.getParameter("emailF"));%>
</body>
</html>