Application = { }

Application.Init = function() {
  Application.Form.Init();
  Application.Grid.Init();
  Application.Menu.Init();
};

$(document).ready(function(){
  Application.Init();
});