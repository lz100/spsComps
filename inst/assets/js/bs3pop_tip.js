// bs3 popover and tooltips on button with hover
$(document).ready(function(){
    $('[pop-toggle="hover"]').popover({
        trigger : 'hover'
    });
    $('[data-toggle="tooltip"]').tooltip();
});

// popover to work on dynamically added elements
$(document).on("DOMNodeInserted", '[pop-toggle="hover"]', function(){
    $(this).popover({
        trigger : 'hover'
    });
});
