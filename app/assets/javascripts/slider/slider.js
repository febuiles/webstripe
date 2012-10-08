var Slider = function(selector, width, height){
  var that = this;
  var paper = Raphael(selector, width, height);
  var height = height;
  var width = width;
  var squares = [];
  var viewport = new Viewport(height);

  this.addSquare = function(selector) {
    var square = new Square(selector);

    square.drawTo(paper, this.nextX(), this.nextY());
    squares.push(square);
  }

  this.nextY = function() {
    var factor = 5;

    if (squares.length % 2 == 0) {
      return (paper.height / 2) - factor;
    } else {
      return (paper.height / 2) + factor;
    }
  }

  this.nextX = function() {
    if (squares.length > 0) {
      return this.lastSquare().xEndsAt();
    } else {
      return 4;
    }
  }

  this.lastSquare = function() {
    if (squares.length > 0) {
      return squares[squares.length - 1]
    }
  }

  this.setViewport = function(e) {
    viewport.moveTo(e.offsetX, that.nextX());
  }

  this.initViewport = function() {
    viewport.addToPaper(paper);
    paper.raphael.click(this.setViewport);
  }
}
