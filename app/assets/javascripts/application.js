// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
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
//= require jquery_nested_form
//= require_tree .

$(function(){
  $(".remove-stripe-item").click(function(e){
    e.preventDefault();
    $(this).parent().remove();
  });

  $("#add-new-text-item").click(function(e){
    e.preventDefault()
    addNewStripeItem("text");
  });

  $("#add-new-embed-item").click(function(e){
    e.preventDefault();
    addNewStripeItem("embed");
  });

  $("#add-new-image-item").click(function(e){
    e.preventDefault();
    addNewStripeItem("image");
  });
});

var addNewStripeItem = function(selector){
  var elem = $("#" + selector + "-template").clone();
  var seed = Math.random().toString().slice(2, -1);
  var html = elem.html().replace(/\{\{seed\}\}/g, seed);
  $(".stripe-items").append(html);
}
