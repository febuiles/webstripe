var Viewport = function(canvasHeight) {
  var width = 40;
  var height = 32;
  var y = (canvasHeight / 2) - (height / 4);
  var strokeColor = "#bc1f19";
  var strokeWidth = 3;
  var rect = null;

  this.addToPaper = function(paper) {
    rect = paper.rect(4, y, 40, 32).attr({ "stroke": strokeColor, "stroke-width": strokeWidth });
  }

  this.moveTo = function(x, rightLimit) {
    var newX = 0;
    if (x + width > rightLimit) { // going too far to the right (nextX)
      newX = rightLimit - width;
    } else if (x < width) {  // or to the left...
      newX = 0;
    } else {
      newX = x - (width / 2);
    }

    $.scrollTo(newX * 20);
    rect.attr("x", newX + 4);
  }
}
