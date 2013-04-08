(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Models.StripeItem = (function(_super) {
    __extends(StripeItem, _super);

    function StripeItem() {
      _ref = StripeItem.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    StripeItem.prototype.paramRoot = 'stripe_item';

    StripeItem.prototype.urlRoot = '/admin/stripe_items';

    StripeItem.prototype.drawNewLink = function() {
      return this.trigger("drawLink");
    };

    StripeItem.prototype.hideRemoveLink = function() {
      return this.trigger("removeLink");
    };

    StripeItem.prototype.showRemoveLink = function() {
      return this.trigger("showLink");
    };

    return StripeItem;

  })(Backbone.RelationalModel);

}).call(this);
