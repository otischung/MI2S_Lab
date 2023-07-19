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
