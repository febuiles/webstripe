(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Collections.Stripes = (function(_super) {

    __extends(Stripes, _super);

    function Stripes() {
      return Stripes.__super__.constructor.apply(this, arguments);
    }

    Stripes.prototype.model = StripeAdmin.Models.Stripe;

    Stripes.prototype.url = '/admin/stripes';

    return Stripes;

  })(Backbone.Collection);

}).call(this);
