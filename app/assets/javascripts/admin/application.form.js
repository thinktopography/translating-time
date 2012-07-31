Application.Form = { }

Application.Form.Init = function() {
  $('div.flash span').live('click', Application.Form.CloseFlash);
}

Application.Form.CloseFlash = function() {
  $(this).closest('div.flash').fadeOut();
}