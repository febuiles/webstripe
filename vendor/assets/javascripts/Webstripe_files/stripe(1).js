(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Models.Stripe = (function(_super) {

    __extends(Stripe, _super);

    function Stripe() {
      return Stripe.__super__.constructor.apply(this, arguments);
    }

    Stripe.prototype.paramRoot = 'stripe';

    Stripe.prototype.urlRoot = '/admin/stripes';

    Stripe.prototype.relations = [
      {
        type: Backbone.HasMany,
        key: 'stripe_items',
        relatedModel: 'StripeAdmin.Models.StripeItem',
        collectionType: 'StripeAdmin.Collections.StripeItems',
        includeInJSON: false,
        reverseRelation: {
          key: 'stripe_id',
          includeInJSON: 'id'
        }
      }
    ];

    return Stripe;

  })(Backbone.RelationalModel);

}).call(this);
