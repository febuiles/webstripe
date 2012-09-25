var StripeItems = function() {
  this.addItem = function(itemType) {
    var itemCollection = $(".stripe-items");
    var item = $(".stripe-item:last");
    var placeholder = $(".stripe-item:last").clone();

    item.append(new HTMLTemplate(itemType).toHTML());
    item.children(".controls").remove();
    itemCollection.append(placeholder);
    restartEventHandlers();
  }
}
