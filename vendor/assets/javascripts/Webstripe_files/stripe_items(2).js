var StripeItem = function(itemType) {
  var collection = $(".stripe-items");
  var item = $(".stripe-item:last");
  var placeholder = $(".stripe-item:last").clone();
  var template = new HTMLTemplate(itemType).toHTML()

  this.render = function() {
    item.append(template);
    item.children(".controls").remove();
    collection.append(placeholder);
  }
}
;
