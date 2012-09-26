$(window).load(function(){
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
      var top = 0;
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
});
