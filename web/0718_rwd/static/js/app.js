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

$(document).ready(function () {
    // Function to gather selected radio values and send them to the backend
    function sendInputAndCategoryToBackend() {
        var selectedRadios = []; // Array to store selected radio values

        // Loop through all the selected radio buttons and add their values to the array
        $('input[name="category"]:checked').each(function () {
            selectedRadios.push($(this).val());
        });

        // Make an Ajax request to send the data to the backend
        $.ajax({
            url: '/summarypost',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                "input": $("#inputTextBox").val(),
                "radios": selectedRadios
            }),
            dataType: "json",
            success: function (response) {
                console.log('Success:', response);
                console.log('Success:', response["status"]);
                $("#Result").text(result["summary"]);
            },
            error: function (xhr, status, error) {
                // Handle any error that occurs during the Ajax request
                console.error('Error:', error);
                console.log(xhr)
                console.log(status)
                $("#Result").text('// 失敗')
                alert('失敗');
            }
        });
    }

    // Attach an event handler to a button (or any element) to trigger the Ajax request
    $("#getSummary").click(function () {
        sendInputAndCategoryToBackend();
    });
});
/*
This means when you're sending JSON to the server or receiving JSON from the server,
you should always declare the Content-Type of the header as application/json as this is
the standard that the client and server understand.
Ref: https://www.freecodecamp.org/news/what-is-the-correct-content-type-for-json-request-header-mime-type-explained/
*/
