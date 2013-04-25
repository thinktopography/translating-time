Application.Grid = {}

Application.Grid.Init = function() {
  $('div.grid thead input').click(Application.Grid.Checkall);
  $('div.grid-header select').change(Application.Grid.Action);
  $('a.delete').click(Application.Grid.Delete);
}

Application.Grid.Delete = function () {
  var url = $(this).attr('href');
  var redirect = window.location.href;
  var confirm = window.confirm("Are you sure you want to delete this?");
  if(confirm) {
    $.ajax({type:'DELETE', url: url, success: function() { window.location = redirect; }});
  }
  return false;
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