
// console.log
console.log("Hello World");
console.error("ERROR: Hello World");
// Selector
console.log($("#first").text());
console.log($(".second").text());
console.log($("third").text());
console.log($("#fourth .fifth").text());
console.log($("#fourth p").text());
console.log($(".sixth.seventh").text());

// SelectorAll
let eighth_p_list = $("#eighth p");
console.log(eighth_p_list);
for (var i = 0; i < eighth_p_list.length; i++) {
    // this is DOM, not jQuery object, wrap with Query
    var item = $(eighth_p_list[i]);
    console.log(i, item.text());
}

// button function
$("#button1").click(function(){
    console.log("button on click");
});
$("#button2").click(function(){
    $("#output1").text("button2 on click");
});

// change attr
function button3_onclick() {
    let my_box = $("#box1");
    console.log("select:", my_box.attr("class"));

    my_box.removeClass("yellow");
    console.log("select:", my_box.attr("class"));

    my_box.addClass("green");
    console.log("select:", my_box.attr("class"));
}

let sw = false;
function button4_onclick() {
    let my_box = $("#img1");
    console.log("select:", my_box.attr("src"));

    my_box.attr("src", "");
    console.log("select:", my_box.attr("src"));

    if (sw) {
        my_box.parent().append('<img id="img1" class="contain" src="static/images/vertical.jpg" alt="替代文字">')
        sw = false;
    } else {
        my_box.parent().append('<img id="img1" class="contain" src="static/images/horizontal.jpg" alt="替代文字">')
        sw = true;
    }

    my_box.attr({
        "src" : "static/images/vertical.jpg",
        "alt" : "改過的替代文字"
    });
    console.log("select:", my_box.attr("src"));
}

// innerHTML outerHTML
let myink_html = $("#mylinks").html();
let myink_outerhtml = $("#mylinks").parent().html();
console.log(myink_html);
console.log(myink_outerhtml);
$("#html2html").html(myink_html);
$("#append").append(myink_html);
$("#prepend").prepend(myink_html);
$("#before").before(myink_html);
$("#after").after(myink_html);

// add delete
$("<div/>").attr("name","hi").text("add_element").appendTo('#add');
$("#delete").remove();