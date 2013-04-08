class StripeAdmin.Collections.StripeItems extends Backbone.Collection
  model: StripeAdmin.Models.StripeItem
  url: '/admin/stripe_items'

  swapStripeItems: (index_a, index_b) ->
    console.log "swap items"
    temp = @models[index_a];
    @models[index_a] = @models[index_b]
    @models[index_b] = temp