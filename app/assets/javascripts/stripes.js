$(window).load(function(){
  var alignment = $("body").data("alignment");
  if (alignment == "horizontal") {
    alignHorizontally();
  } else {
    alignVertically();
  }

  var numItems = $("div.item").length;
  var slider = new Slider("slider", 600, 65);
  $("div.item").each(function(i, item) {
    slider.addSquare(item);
  });

  slider.initViewport();
});

var alignVertically = function() {
  var children = $("#show-stripe").children();

  for (var i = 0; i < children.length; i++) {
    var child = $(children[i]);
    var lastChild = $(children[i - 1]);
    var childWidth = child.width();
    var moveFactor = parseInt(childWidth * 0.1);
    var border = parseInt(child.css("border-left-width"));

    if (child.children("img").length > 0) {      // image
      var imgHeight = child.children("img").height();
      child.css("height", imgHeight);
    }

    if (i == 0) {
      var top = 200;
    } else {
      var lastTop = parseInt(lastChild.css("top"));
      var lastHeight = lastChild.height();
      var top = lastTop + lastHeight + border;
    }

    child.css("top", top);

    if ((i + 1) % 2 == 0) {     // even
      child.css("margin-left", moveFactor)
    } else {
      child.css("margin-left", -moveFactor)
    }
  };
}

var alignHorizontally = function() {
  var children = $("#show-stripe").children();

  for (var i = 0; i < children.length; i++) {
    var child = $(children[i]);
    var lastChild = $(children[i - 1]);
    var childWidth = child.width();
    var moveFactor = parseInt(childWidth * 0.1);
    var border = parseInt(child.css("border-left-width"));

    if (child.children("img").length > 0) {      // image
      var imgWidth = child.children("img").width();
      child.css("width", imgWidth);
    }

    if (i == 0) {
      var left = 0;
    } else {
      var lastLeft = parseInt(lastChild.css("left"));
      var lastWidth = lastChild.width();
      var left = lastLeft + lastWidth + border;
    }
    child.css("left", left);

    if ((i + 1) % 2 == 0) {     // even
      child.css("margin-top", moveFactor)
    } else {
      child.css("margin-top", -moveFactor)
    }
  };
}