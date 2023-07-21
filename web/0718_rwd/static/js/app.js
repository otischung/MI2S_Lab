// This function will auto-resize the text area.
$(document).ready(function () {
    // Select the textarea element
    var textarea = $('#inputTextBox');

    // Maximum number of rows allowed
    var maxRows = 20;

    // Set the initial number of rows based on the content
    textarea.attr('rows', textarea.val().split('\n').length);

    // Function to auto-resize the textarea
    function autoResize() {
        var rows = textarea.val().split('\n').length;
        if (rows > maxRows) {
            rows = maxRows;
            textarea.val(textarea.val().split('\n').slice(0, maxRows).join('\n'));
        }
        textarea.attr('rows', rows);
    }

    // Call the autoResize function whenever the user types
    textarea.on('input', autoResize);
});

// This function maintains the ajax API for the summit button
$("#getSummary").click(function () {
    console.log("Button on click");  // For debugging
    var val = $(".category:checked").val();
    alert(val);
    $.ajax({
        method: "POST",
        url: "/summarypost",
        contentType: 'application/json',
        data: JSON.stringify($("#inputTextBox").val()),
        dataType: "json",
    })
        .done(function (result) {
            console.log(result);
            console.log(result["status"]);
            alert('成功');
        })
        .fail(function () {
            alert('失敗');
        })
        .always(function () {
            alert('結束');
        });
});
/*
This means when you're sending JSON to the server or receiving JSON from the server,
you should always declare the Content-Type of the header as application/json as this is
the standard that the client and server understand.
Ref: https://www.freecodecamp.org/news/what-is-the-correct-content-type-for-json-request-header-mime-type-explained/
*/
