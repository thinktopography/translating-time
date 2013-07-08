Application.Form = { }

Application.Form.Init = function() {
  $('div.flash span').live('click', Application.Form.CloseFlash);
  $('div#curation_grid div.grid-prefix select').live('change', Application.Form.ChangeSpecies);
  $('div#curation_grid label.curate').live('click', Application.Form.Curate);
  $('div#curation_grid label.uncurate').live('click', Application.Form.Uncurate);
  $('div.form :input:first').focus();
  $('span.togglemce').click(Application.Form.Toggle)
  $('input#min,input#max').focus(function() { $(this).blur(); });
  $('#species_1').change(Application.Form.SetMinMax);
  $('#species_1,#species_2').change(Application.Form.DisplayMinMax);
  $('form.predict select').change(Application.Form.Predict);
  $('div#observations select').change(Application.Form.Observations);
  $('span.toggle').click(Application.Form.CheckAll);
}

Application.Form.CheckAll = function() {
  $(this).next('ul').find('li:visible input').attr('checked', 'checked');
}

Application.Form.Observations = function() {
  var location = $('div#observations select#location').val();
  var process = $('div#observations select#process').val();
  $('dd.events li').show();
  if(location || process) {
    $('dd.events li').hide();
    $('dd.events input').removeAttr('checked');
    if(location && process) {
      $('li.location_'+location+'.process_'+process).show();
    } else if(location) {
      $('li.location_'+location).show();
    } else if(process) {
      $('li.process_'+process).show();
    }
  }
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
  if(!confirm('Are you sure you want to curate this observation?')) return false;
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

Application.Form.Uncurate = function() {
  if(!confirm('Are you sure you want to uncurate this observation?')) return false;
  var label = $(this);
  var event_id = label.data('event_id');
  var species_id = label.data('species_id');
  var row = label.closest('tr');
  if(!label.hasClass('active')) {
    $.ajax({
      url: '/admin/observations/clear',
      data: 'event_id='+event_id+'&species_id='+species_id,
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
