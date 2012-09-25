// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require_tree ./admin

$(function(){
  restartEventHandlers();
});

var stripeItems = new StripeItems();

var clickHandler = function(itemType) {
  return function(ev) {
    stripeItems.addItem(itemType);
  }
}

var removeHandler = function(ev) {
  $(this).closest("div.stripe-item").remove();
}

var restartEventHandlers = function() {
  $(".add-new-text-item").click(clickHandler("text"));
  $(".add-new-embed-item").click(clickHandler("embed"));
  $(".add-new-image-item").click(clickHandler("image"));
  $("a.remove-stripe-item").click(removeHandler);
}