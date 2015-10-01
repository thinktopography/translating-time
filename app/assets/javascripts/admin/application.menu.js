Application.Menu = {}

Application.Menu.Init = function() {
  $("body").delegate("presence", "click", Application.Menu.Open);
  $("body").delegate("presence.active", "mouseleave", Application.Menu.Close);
};

Application.Menu.Open = function() {
  $("presence").toggleClass('active');
};

Application.Menu.Close = function() {
  $("presence").removeClass('active');
};