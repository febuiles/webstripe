(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Views.ShowStripeItem = (function(_super) {
    __extends(ShowStripeItem, _super);

    function ShowStripeItem() {
      _ref = ShowStripeItem.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ShowStripeItem.prototype.template = JST['admin/stripe_items/show_stripe_item'];

    ShowStripeItem.prototype.el = "<div class='stripe-item' />";

    ShowStripeItem.prototype.events = {
      'click': 'focusStripeItem'
    };

    ShowStripeItem.prototype.initialize = function() {
      console.log("init Show Stripe Item");
      this.model.on('change', this.render, this);
      return this.model.on('add_content', this.addContent, this);
    };

    ShowStripeItem.prototype.render = function() {
      console.log("render Show Stripe Item");
      $(this.el).html(this.template({
        stripe_item: this.model
      }));
      return this;
    };

    ShowStripeItem.prototype.addContent = function() {
      var img;

      console.log("add content");
      console.log(this.model.get('image'));
      img = $(document.createElement('img'));
      img.attr('src', this.model.get('image'));
      return this.$("#content").prepend(img);
    };

    ShowStripeItem.prototype.focusStripeItem = function(e) {
      e.preventDefault();
      return typeof console !== "undefined" && console !== null ? console.log("Focusing on tool " + (this.model.get('id')) + " - " + (this.model.get('position'))) : void 0;
    };

    ShowStripeItem.prototype.leave = function() {
      console.log("leave Show Stripe Item");
      this.model.off("change", this.render, this);
      return this.model.off("add_content", this.add_content, this);
    };

    return ShowStripeItem;

  })(Support.CompositeView);

}).call(this);
