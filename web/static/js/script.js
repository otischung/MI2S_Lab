var input = document.querySelector("input");
var output = document.getElementById("title");
var h2 = document.querySelector("h2");
var h3 = document.querySelector("h3");

function setText() {
    output.textContent = input.value;
    h2.innerHTML = "<img src='./static/Li_si_leh_kong_sann_siau_.webp' style='width: 50;'>"
    h3.innerHTML = "<button onclick='reloadPage()'>回上一頁</button>";
}

function reloadPage() {
    window.location.reload()
}

// Ref: https://blog.devgenius.io/how-to-detect-the-pressing-of-the-enter-key-in-a-text-input-field-with-javascript-380fb2be2b9e
const input1 = document.querySelector("input");
input1.addEventListener("keyup", (event) => {
    if (event.key === "Enter") {
        setText();
    }
});
