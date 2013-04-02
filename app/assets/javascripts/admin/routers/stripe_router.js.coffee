class StripeAdmin.Routers.Stripe extends Support.SwappingRouter
  routes:
    'admin/stripes/new': 'new'

  initialize: ->
    console?.log("New stripe router")
    @el = $("div.new-stripe-container")
    @stripe = new StripeAdmin.Models.Stripe($('#stripe_items_data').data('stripe'))
    @stripe_items = new StripeAdmin.Collections.StripeItems()
    @stripe_items = @stripe.get('stripe_items')

  new: ->
    @swap(new StripeAdmin.Views.StripeItems({collection: @stripe_items}))