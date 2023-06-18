function toggleColor() {
    var element = document.getElementById("bar");
    if(window.getComputedStyle(element).getPropertyValue("background-color") == "rgb(51, 51, 51)"){
        element.style.backgroundColor = "#b0aeae";
    }else{
        element.style.backgroundColor = "#333";
    }

    if(window.getComputedStyle(document.body).getPropertyValue("background-color") == "rgb(0, 0, 0)"){
        document.body.style.backgroundColor = "#FFF";
    }else{
        document.body.style.backgroundColor = "#000";
    }

    var elements = document.getElementsByClassName("txt");
    for (var i = 0; i < elements.length; i++) {
        if(window.getComputedStyle(elements[i]).getPropertyValue('color') == "rgb(255, 255, 255)"){
            elements[i].style.color = "#000";
        }else{
            elements[i].style.color = "#FFF";
        }
    }
}