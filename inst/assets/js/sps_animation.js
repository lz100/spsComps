

function addSpsAnimation(selector, addClass){
  $(()=>{
    $(selector).addClass(addClass);
  });
}

Shiny.addCustomMessageHandler('sps-add-animation', function(data) {
  addSpsAnimation(data.selector, data.addClass);
});


Shiny.addCustomMessageHandler('sps-remove-animation', function(data) {
  var el = $(data.selector);
  if (el.hasClass('sps-animation')) {
    el.removeClass(function(index, className) {
      return className.match(/(faa-.*\s{0,}|animated-hover|animated| sps-animation)/g).join(' ')
    });
  } else if (data.alert) {
    alert(`Selector '${data.selector}' does not have animation or the animation is not added by spsComps, cannot remove.`)
  }
});
