$("#buttonCount").click(function(){
    console.log("Hello");
    $.ajax({
        method: "POST",
        url: "/adderResult",
        contentType: 'application/json',
        data: JSON.stringify([$("#x"), $("#y")]),
        dataType: "json",
    })
    .done(function(result) {
        console.log(result);
        $("#adderResult").text(result["status"]);
    })
    .fail(function() {
        $("#output1").text('fail');
    })
    .always(function() {
        alert('結束');
    });
});

$("#button").click(function(){
    console.log("button on click");
    var text = {
        name: "John",
        location: "Boston",
    };
    $.ajax({
        method: "POST",
        url: "/testpost",
        contentType: 'application/json',
        data: JSON.stringify(text),
        dataType: "json",
    })
    .done(function(result) {
        console.log(result);
        console.log(result["status"]);
        alert('成功');
    })
    .fail(function() {
        alert('失敗');
    })
    .always(function() {
        alert('結束');
    });
});

$.fn.serializeForm = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$("#button1").click(function(){
    console.log("button1 on click");
    $.ajax({
        method: "POST",
        url: "/testformpost",
        contentType: 'application/json',
        data: JSON.stringify($("#form1").serializeForm()),
        dataType: "json",
    })
    .done(function(result) {
        console.log(result);
        $("#output1").text(result["status"]);
    })
    .fail(function() {
        $("#output1").text('fail');
    })
    .always(function() {
        alert('結束');
    });
});


