<!DOCTYPE html>
<html>
<head>
	<title>MexTextWeb</title>
	<link rel="stylesheet" type="text/css" href="index.css">
	<script src="index.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script type="text/javascript" src="sha3.js"></script>
</head>
<body>
	<div class="main" id="login-register">
		<input type="checkbox" id="chk" aria-hidden="true">
		<%
			if (!session.isNew()) {
				session.invalidate();
			}
		%>
			<div class="signup">
				<form action="register.jsp" method="post" id="signupForm">
					<label for="chk" aria-hidden="true" style="margin-bottom: 0;">Sign up</label>
					<input type="text" name="txt" placeholder="Nickname" required="" autocomplete="off">
					<input type="email" name="email" placeholder="Email" required="" autocomplete="off">
					<div class="password-container">
						<input type="password" name="pswd" id="pswd" placeholder="Password" required="" autocomplete="off" oninput="checkPasswordsMatch()">
						<span class="password-toggle" id="toggle" onclick="togglePasswordVisibility()"><i id="eye" class="fa fa-eye"></i></span>
					</div>            
					<div class="password-container">
						<input type="password" name="pswd1" id="pswd1" placeholder="Password" required="" autocomplete="off" oninput="checkPasswordsMatch()">
						<span class="password-toggle" id="toggle1" onclick="togglePasswordVisibility1()"><i id="eye1" class="fa fa-eye"></i></span>
						<span class="tooltip" id="toolt">Passwords don't match</span>
					</div>
					<center><p style="font-size: 0.7em; color: aliceblue;">Cliccando accetti il trattamento dei dati secondo la normativa<br>del <a href="download/Privacy.pdf" download="Privacy.pdf" style="color:aqua">Regolamento Europeo 2016/679</a></p></center>
					<button type="submit" id="signupBtn" disabled onclick="cryptR()">Sign up</button>
				</form>
			</div>

			<div class="login">
				<form action="mextext/mextext.jsp" method="post" id="loginForm">
					<label for="chk" aria-hidden="true" style="margin-bottom: 0;">Login</label>
					<input type="text" name="loginTxt" placeholder="Nickname" required="" autocomplete="off">
					<input type="password" name="loginPswd" id="loginPswd" placeholder="Password" required="" autocomplete="off">
					<span class="password-toggle" id="toggle2" onclick="togglePasswordVisibility2()"><i id="eye2" class="fa fa-eye"></i></span>
					<button type="submit" onclick="cryptL()">Login</button>
				</form>
				<button id="forgot" onclick="forgotNickOrPassw()">Forgot password or nickname?</button>
			</div>
	</div>

	<div id="forgotNick-Psw">
		<form action="ForgotNick-Psw/forgot.jsp" method="post">
			<label for="emailF">Forgot Nickname or Password</label>
			<input type="email" name="emailF" placeholder="Email" required="" autocomplete="off">
			<button type="submit">Send Email</button>
		</form>
	</div>
</body>
</html>