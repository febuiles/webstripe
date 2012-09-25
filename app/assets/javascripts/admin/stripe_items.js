var StripeItems = function() {
  this.addItem = function(itemType) {
    var selector = $(".stripe-items");
    var item = $(".stripe-item:last-child").clone();

    selector.append(item);
  }
}
