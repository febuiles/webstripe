class StripeAdmin.Models.StripeItem extends Backbone.RelationalModel

  defaults:
    item_type: "text"

  isFirstStripeItem: (index) ->
    return index is 0

  isLastStripeItem: (index, length) ->
    return index >= length - 1