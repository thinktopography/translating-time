Application.Grid = {}

Application.Grid.Init = function() {
  $('div.grid thead input').click(Application.Grid.Checkall);
  $('div.grid-header select').change(Application.Grid.Action);
}

Application.Grid.Checkall = function() {
  if($(this).is(':checked')) {
    $('tbody input[type=checkbox]').attr('checked', 'checked');
  } else {
    $('tbody input[type=checkbox]').removeAttr('checked');
  }
}

Application.Grid.Action = function() {
  $(this).closest('form').submit();
  return false;
}