class StripeAdmin.Routers.Stripe extends Support.SwappingRouter
  routes:
    'admin/stripes/new': 'new'

  initialize: ->
    console?.log("New stripe router")
    #@el = $("div.primary_content")
    @el = $("div.new-stripe-container")
    @stripe = new StripeAdmin.Models.Stripe($('#stripe_items_data').data('stripe'))
    @stripe_items = new StripeAdmin.Collections.StripeItems()
    @stripe_items = @stripe.get('stripe_items')
    console?.log @stripe_items

  new: ->
    @swap(new StripeAdmin.Views.StripeItems(collection: @stripe_items))
    # view = new StripeAdmin.Views.StripeItems(collection: @stripe_items)
    # $('.new-stripe-container').empty()
    # $('.new-stripe-container').html(view.render().el)
