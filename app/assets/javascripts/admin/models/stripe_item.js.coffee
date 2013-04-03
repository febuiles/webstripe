class StripeAdmin.Models.StripeItem extends Backbone.RelationalModel
  paramRoot: 'stripe_item'
  urlRoot: '/admin/stripe_items'

  defaults:
    item_type: "text"
