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

    button{
        width: 60%;
        height: 40px;
        margin: 10px auto;
        display: block;
        color: #fff;
        background: #8a3b3b;
        font-size: 1em;
        font-weight: bold;
        margin-top: 20px;
        outline: none;
        border: none;
        border-radius: 5px;
        transition: .2s ease-in;
        cursor: pointer;
    }
</style>
<body>
    <jsp:useBean id="SessionDB" scope="session" class="mieiBean.MexTextDB"/>

    <jsp:setProperty name="SessionDB" property="password" value='<%=request.getParameter("pswd")%>'/>
	<jsp:setProperty name="SessionDB" property="token" value='<%=request.getParameter("token")%>'/>
    <label id="reset" style="display: none;"><jsp:getProperty name="SessionDB" property="resetPswd"/></label>
    <div>
        <h1 id="txt"></h1>
        <a href="../index.jsp"><button>Login</button></a>
    </div>

    <script>
        if(document.getElementById("reset").innerText == "false"){
            document.getElementById("txt").innerText = "Error in password reset, please try again!";
        }else{
            document.getElementById("txt").innerText = "Password changed!";
        }
    </script>
</body>
</html>