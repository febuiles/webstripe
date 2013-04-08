var HTMLTemplate = function(itemType) {
  var type = itemType;
  var elem = $("#" + type + "-template").clone();

  this.toHTML = function() {
    elem.attr("id", "");
    return this.parseTemplate();
  };

  this.parseTemplate = function() {
    return elem.html().replace(/\{\{seed\}\}/g, this.getRandomSeed());
  };

  this.getRandomSeed = function() {
    return Math.random().toString().slice(2, -1);
  };
}
;
