(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Collections.StripeItems = (function(_super) {

    __extends(StripeItems, _super);

    function StripeItems() {
      return StripeItems.__super__.constructor.apply(this, arguments);
    }

    StripeItems.prototype.model = StripeAdmin.Models.StripeItem;

    StripeItems.prototype.url = '/admin/stripe_items';

    StripeItems.prototype.isFirstSlide = function(index) {
      return index === 0;
    };

    StripeItems.prototype.isLastSlide = function(index) {
      return index === (this.models.length - 1);
    };

    StripeItems.prototype.drawNewLink = function() {
      return this.last().drawNewLink();
    };

    StripeItems.prototype.drawRemoveLink = function() {
      if (this.models.length > 1) {
        return this.first().showRemoveLink();
      } else {
        return this.first().hideRemoveLink();
      }
    };

    return StripeItems;

  })(Backbone.Collection);

}).call(this);
