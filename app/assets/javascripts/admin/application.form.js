Application.Form = { }

Application.Form.Init = function() {
  $('div.flash span').live('click', Application.Form.CloseFlash);
  $('div#curation_grid div.grid-prefix select').live('change', Application.Form.ChangeSpecies);
  $('div#curation_grid label').live('click', Application.Form.Curate);
  $('div.form :input:first').focus();
  $('span.togglemce').click(Application.Form.Toggle)
  $('input#min,input#max').focus(function() { $(this).blur(); });
  $('#species_1').change(Application.Form.SetMinMax);
  $('#species_1,#species_2').change(Application.Form.DisplayMinMax);
  $('form.predict select').change(Application.Form.Predict);
}

Application.Form.Predict = function() {
  var form = $('form.predict');
  var species = $('#species_id').val();
  var event = $('#event_id').val();
  if(species && event) {
    form.submit();
  }
}

Application.Form.SetMinMax = function() {
  var selected = $(this).find(':selected');
  var min = selected.data('min');
  var max = selected.data('max');
  $('input#translation_min').val(min);
  $('input#translation_max').val(max);
}

Application.Form.DisplayMinMax = function() {
  var selected = $(this).find(':selected');
  var min = selected.data('min');
  var max = selected.data('max');
  var container = $(this).closest('dd');
  container.find('span.range').html("[ Post Conception Day range: "+min+" - "+max+" ]");
}

Application.Form.Toggle = function() {
  if(!tinyMCE.get('page_body')) {
   tinyMCE.execCommand('mceAddControl', false, 'page_body');
  } else {
    tinyMCE.execCommand('mceRemoveControl', false, 'page_body');
  }
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
