
Shiny.addCustomMessageHandler('sps-checkpkg', function(data) {
  // type, title, body
  Swal.fire({
    icon: 'error',
    title: data.title,
    html: data.body
  });
  $('.swal2-popup.swal2-modal').css("font-size", "1.6rem");
});
