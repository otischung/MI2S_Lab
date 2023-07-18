
// console.log
console.log("Hello World 123");
console.error("ERROR: Hello World");
// querySelector
console.log(document.querySelector("#first").innerText);
console.log(document.querySelector(".second").innerText);
console.log(document.querySelector("third").innerText);
console.log(document.querySelector("#fourth .fifth").innerText);
console.log(document.querySelector("#fourth p").innerText);
console.log(document.querySelector(".sixth.seventh").innerText);

// querySelectorAll
let eighth_p_list = document.querySelectorAll("#eighth p");
console.log(eighth_p_list);
for (var i = 0; i < eighth_p_list.length; i++) {
    var item = eighth_p_list[i];
    console.log(i, item.innerText);
}

// button function
function button1_onclick() {
    console.log("button on click");
}
function button2_onclick() {
    document.querySelector("#output1").innerText = "button2 on click";
}

// change attr
function button3_onclick() {
    let my_box = document.querySelector("#box1");
    console.log("select:", my_box.getAttribute("class"));

    // my_box.classList.remove("yellow");
    console.log("remove:", my_box.getAttribute("class"));

    my_box.classList.add("green");
    console.log("set:", my_box.getAttribute("class"));
}

let sw = false;
function button4_onclick() {
    let my_img = document.querySelector("#img1");
    console.log("select:", my_img.getAttribute("src"));

    my_img.removeAttribute("src");
    console.log("remove:", my_img.getAttribute("src"));

    if (sw) {
        my_img.setAttribute("src", "static/images/horizontal.jpg");
        sw = false;
    } else {
        my_img.setAttribute("src", "static/images/vertical.jpg");
        sw = true;
    }
    console.log("set:", my_img.getAttribute("src"));
}

// innerText innerHTML
let myink_text = document.querySelector("#mylinks").innerText;
let myink_html = document.querySelector("#mylinks").innerHTML;
console.log(myink_text);
console.log(myink_html);
document.querySelector("#text2text").innerText = myink_text;
document.querySelector("#text2html").innerHTML = myink_text;
document.querySelector("#html2text").innerText = myink_html;
document.querySelector("#html2html").innerHTML = myink_html;

// add delete
let add_element = document.createElement('div');
add_element.innerText = "add_element";
add_element.setAttribute("name", "hi");
console.log(add_element.outerHTML);
document.querySelector("#add").innerHTML = add_element.outerHTML;
document.querySelector("#delete").remove();


