(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Routers.Stripe = (function(_super) {
    __extends(Stripe, _super);

    function Stripe() {
      _ref = Stripe.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Stripe.prototype.routes = {
      'admin/stripes/new': 'new'
    };

    Stripe.prototype.initialize = function() {
      if (typeof console !== "undefined" && console !== null) {
        console.log("New stripe router");
      }
      this.el = $("div.new-stripe-container");
      this.stripe = new StripeAdmin.Models.Stripe($('#stripe_items_data').data('stripe'));
      this.stripe_items = new StripeAdmin.Collections.StripeItems();
      this.stripe_items = this.stripe.get('stripe_items');
      return typeof console !== "undefined" && console !== null ? console.log(this.stripe_items) : void 0;
    };

    Stripe.prototype["new"] = function() {
      return this.swap(new StripeAdmin.Views.StripeItems({
        collection: this.stripe_items
      }));
    };

    return Stripe;

  })(Support.SwappingRouter);

}).call(this);
