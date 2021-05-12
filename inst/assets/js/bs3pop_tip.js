//$(document).ready(function(){
//    $('[pop-toggle="hover"]').popover({
//        trigger : 'hover',
//        container: 'body'
//    });
//    $('[data-toggle="tooltip"]').tooltip();
//});
//
//// popover to work on dynamically added elements
//$(document).on("DOMNodeInserted", '[pop-toggle="hover"]', function(){
//    $(this).popover({
//        trigger : 'hover',
//        container: 'body'
//    });
//});



function bsTooltip(tipid, placement, title, bgcolor, textcolor, fontsize, trigger) {
  $(`[data-tipid="${tipid}"]`)
    .tooltip({
        placement: placement,
        title: title,
        trigger: trigger
      })
    .on('inserted.bs.tooltip', function(){
      var tip = $(`#${$(this).attr("aria-describedby")}`);
      console.log(tip)

      tip.find('.tooltip-arrow').css(`border-${placement}-color`, bgcolor);
      tip.find('.tooltip-inner').css({
        backgroundColor: bgcolor,
        fontSize: fontsize,
        color: textcolor
      });
    })
}
