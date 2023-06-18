function tk(){
    var url_string = window.location.href;
    var url = new URL(url_string);
    var tk = url.searchParams.get("token");
    document.getElementById("token").value = tk;
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

function checkPasswordsMatch() {
    var password = document.getElementById("pswd").value;
    var confirmPassword = document.getElementById("pswd1").value;
    var confirmBtn = document.getElementById("confirm");
    var tooltip = document.getElementById("toolt");

    if (password === confirmPassword && password !== "") {
        confirmBtn.disabled = false;
        tooltip.style.display = "none";
    } else {
        confirmBtn.disabled = true;
        tooltip.style.display = "flex";
    }
}

function cryptL(){
    const shaObj = new jsSHA("SHA3-512", "TEXT", { encoding: "UTF8" });
    shaObj.update(document.getElementById("pswd").value);
    const hash = shaObj.getHash("HEX");
    document.getElementById("pswd").value = hash;
}