var Square = function(element, factor) {
  var div = $(element);
  var scaleFactor = 0.05 * (factor || 1) ;
  var color = "#e7e6cb";
  var height = parseInt(div.height()) * scaleFactor;
  var width = parseInt(div.width()) * scaleFactor;
  var rect = null;

  this.drawTo = function(paper, x, y) {
    rect = paper.rect(x, y, width, height).attr({ fill: color, stroke: color });
  }

  this.xEndsAt = function() {
    return this.x() + this.width();
  }

  this.x = function() { return rect.attr("x"); }
  this.y = function() { return rect.attr("y"); }
  this.height = function() { return rect.attr("height"); }
  this.width = function() { return rect.attr("width"); }
}