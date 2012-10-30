var Viewport = function(canvasHeight, canvasWidth, factor) {
  var width = 40;
  var height = 32;
  var y = (canvasHeight / 2) - (height / 4);
  var strokeColor = "#bc1f19";
  var strokeWidth = 3;
  var rect = null;
  var factor = factor || 1
  var whitespace = null;    // initial left padding or margin-bottom for vertical stripes

  // HACK ALERT: Fix this pos. code.

  if ($("body").data("alignment") == "vertical") {
    // 150 is the margin-bottom of the last element
    whitespace = 150;
    var scrollFactor = (($(document).height() + whitespace) / canvasWidth);
  } else {
    whitespace = 400;
    var scrollFactor = (($(document).width() - whitespace) / canvasWidth);
  }

  this.addToPaper = function(paper) {
    rect = paper.rect(4, y, width, height).attr({ "stroke": strokeColor, "stroke-width": strokeWidth });
  }

  this.move = function(e, rightLimit) {
    var x = e.hasOwnProperty('offsetX') ? e.offsetX : e.layerX;
    var constructor = e.target.constructor;

    if (constructor != SVGRectElement) {
      return
    }

    this.moveTo(x, rightLimit);
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
    $.scrollTo((newX * scrollFactor) + whitespace);
    rect.attr("x", newX + 4);
  }

  this.moveRight = function(pixels) {
    rect.attr("x", rect.attr("x") + pixels / scrollFactor);
  }
  this.moveLeft = function(pixels) {
    rect.attr("x", rect.attr("x") - (pixels / scrollFactor));
  }
}
