Application.Menu = {}

Application.Menu.Init = function() {
  $("presence").live("click", Application.Menu.Open);
  $("presence.active").live("mouseleave", Application.Menu.Close);
}

Application.Menu.Open = function() {
  $("presence").toggleClass('active');
}

Application.Menu.Close = function() {
  $("presence").removeClass('active');
}