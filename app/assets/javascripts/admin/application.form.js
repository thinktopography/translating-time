Application.Form = { }

Application.Form.Init = function() {
  $('div.flash span').live('click', Application.Form.CloseFlash);
  $('div#locations_grid div.grid-prefix select').live('change', Application.Form.ChangeSpecies);
  $('div.form :input:first').focus();
}

Application.Form.CloseFlash = function() {
  $(this).closest('div.flash').fadeOut();
}

Application.Form.ChangeSpecies = function() {
  var id = $(this).val();
  alert(id);
}
