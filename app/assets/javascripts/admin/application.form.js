Application.Form = { }

Application.Form.Init = function() {
  $('div.flash span').live('click', Application.Form.CloseFlash);
  $('div#curation_grid div.grid-prefix select').live('change', Application.Form.ChangeSpecies);
  $('div#curation_grid label').live('click', Application.Form.Curate);
  $('div.form :input:first').focus();
}

Application.Form.Curate = function() {
  var label = $(this);
  var id = label.find('input').val();
  var row = label.closest('tr');
  if(!label.hasClass('active')) {
    $.ajax({
      url: '/admin/observations/'+id+'/adjust',
      success: function() {
        row.find('label.active').removeClass('active');
        label.addClass('active');
      }
    })
  }
  return false;
}

Application.Form.CloseFlash = function() {
  $(this).closest('div.flash').fadeOut();
}

Application.Form.ChangeSpecies = function() {
  var id = $(this).val();
  window.location = '/admin/observations/curate?species_id='+id
}
