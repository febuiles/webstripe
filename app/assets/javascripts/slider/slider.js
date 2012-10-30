var Slider = function(selector, width, height){
  var that = this;
  var paper = Raphael(selector, width, height);
  var height = height;
  var width = width;
  var squares = [];
  var scrollPosition = 0;
  var $selector = $("#" + selector);
  var factor = 1;
  var viewport = null;


  this.addSquare = function(selector) {
    if ($("div.item").length > 20) {
      factor = 0.5;
    }

    var square = new Square(selector, factor);

    square.drawTo(paper, this.nextX(), this.nextY());
    squares.push(square);
  }


  this.nextY = function() {
    var factor = 3;

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

  this.realWidth = function () {
    return this.lastSquare().x() + this.lastSquare().width();
  }

  this.lastSquare = function() {
    if (squares.length > 0) {
      return squares[squares.length - 1]
    }
  }

  this.setViewport = function(e) {
    viewport.move(e, that.nextX());
  }

  this.handleScroll = function(e) {
    var current = $(window).scrollTop();
    if (current < scrollPosition ) { // scroll up
    } else if (current > scrollPosition ) { // scroll down
    }
    scrollPosition = current;
  }

  this.initViewport = function() {
    viewport = new Viewport(height, this.realWidth(), factor);
    viewport.addToPaper(paper);
    paper.raphael.click(this.setViewport);
    $(window).scroll(this.handleScroll);
  }
}
