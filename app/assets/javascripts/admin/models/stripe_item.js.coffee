class StripeAdmin.Models.StripeItem extends Backbone.RelationalModel
  urlRoot: '/admin/stripe_items'
  defaults:
    item_type: "text"
    content: ""

  isFirstStripeItem: (index) ->
    return index is 0

  isLastStripeItem: (index, length) ->
    return index >= length - 1