window.addEventListener('pageshow', function(event) {
    if (event.persisted) {
      location.reload();
    }
});
  

function forgotNickOrPassw(){
    document.getElementById("login-register").style.display = "none";
    document.getElementById("forgotNick-Psw").style.display = "flex";
}

function togglePasswordVisibility() {
    var passwordInput = document.getElementById("pswd");
    var passwordToggle = document.getElementById("toggle");
    var eyes = document.getElementById("eye");

    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        passwordToggle.classList.add("active");
        eyes.classList.remove("fa-eye");
        eyes.classList.add("fa-eye-slash");
    } else {
        passwordInput.type = "password";
        passwordToggle.classList.remove("active");
        eyes.classList.remove("fa-eye-slash");
        eyes.classList.add("fa-eye");
    }
}

function togglePasswordVisibility1() {
    var passwordInput1 = document.getElementById("pswd1");
    var passwordToggle1 = document.getElementById("toggle1");
    var eyes1 = document.getElementById("eye1");

    if (passwordInput1.type === "password") {
        passwordInput1.type = "text";
        passwordToggle1.classList.add("active");
        eyes1.classList.remove("fa-eye");
        eyes1.classList.add("fa-eye-slash");
    } else {
        passwordInput1.type = "password";
        passwordToggle1.classList.remove("active");
        eyes1.classList.remove("fa-eye-slash");
        eyes1.classList.add("fa-eye");
    }
}

function togglePasswordVisibility2() {
    var passwordInput2 = document.getElementById("loginPswd");
    var passwordToggle2 = document.getElementById("toggle2");
    var eyes2 = document.getElementById("eye2");

    if (passwordInput2.type === "password") {
        passwordInput2.type = "text";
        passwordToggle2.classList.add("active");
        eyes2.classList.remove("fa-eye");
        eyes2.classList.add("fa-eye-slash");
    } else {
        passwordInput2.type = "password";
        passwordToggle2.classList.remove("active");
        eyes2.classList.remove("fa-eye-slash");
        eyes2.classList.add("fa-eye");
    }
}

function checkPasswordsMatch() {
    var password = document.getElementById("pswd").value;
    var confirmPassword = document.getElementById("pswd1").value;
    var signupBtn = document.getElementById("signupBtn");
    var tooltip = document.getElementById("toolt");

    if (password === confirmPassword && password !== "") {
        signupBtn.disabled = false;
        tooltip.style.display = "none";
    } else {
        signupBtn.disabled = true;
        tooltip.style.display = "flex";
    }
}

function cryptL(){
    const shaObj = new jsSHA("SHA3-512", "TEXT", { encoding: "UTF8" });
    shaObj.update(document.getElementById("loginPswd").value);
    const hash = shaObj.getHash("HEX");
    document.getElementById("loginPswd").value = hash;
}

function cryptR(){
    const shaObj = new jsSHA("SHA3-512", "TEXT", { encoding: "UTF8" });
    shaObj.update(document.getElementById("pswd").value);
    const hash = shaObj.getHash("HEX");
    document.getElementById("pswd").value = hash;
}