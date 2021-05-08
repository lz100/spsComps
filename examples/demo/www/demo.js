
// animation for new
$(function(){
  var el = $("#sidebarItemExpanded")
    .find('a[href="#shiny-tab-animation"], a[href="#shiny-tab-loader"]');
  el.find("small").addClass('faa-pulse animated');
  el.on('click', function() {
    $(this).find("small").fadeOut();
  })
});

// add target blank
$(()=>{
  $('a:contains("{blk}")').each(function(){
    $(this)
      .text($(this).text().replace("{blk}", ""))
      .attr("target", "_blank");
  });
});


























