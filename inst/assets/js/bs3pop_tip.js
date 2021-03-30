$(document).ready(function(){
    $('[pop-toggle="hover"]').popover({
        trigger : 'hover',
        container: 'body'
    });
    $('[data-toggle="tooltip"]').tooltip();
});

// popover to work on dynamically added elements
$(document).on("DOMNodeInserted", '[pop-toggle="hover"]', function(){
    $(this).popover({
        trigger : 'hover',
        container: 'body'
    });
});
