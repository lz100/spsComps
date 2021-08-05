Shiny.addCustomMessageHandler("sps-update-timeline", function(data) {
    if (data.complete === true) $(data.id).addClass("complete")
    else $(data.id).removeClass("complete")
    if (data.upLabel !== null) $(`${data.id} .sps-timestamp span`).text(data.upLabel)
    if (data.downLabel !== null) $(`${data.id} .status h4`).text(data.downLabel)
});

