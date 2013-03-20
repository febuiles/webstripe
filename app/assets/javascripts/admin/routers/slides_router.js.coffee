class StripeAdmin.Routers.Slides extends Backbone.Router
  routes:
    'admin/stripes/new': 'new'

  initialize: ->
    @stripe = new StripeAdmin.Models.Stripe($('#stripe_items_data').data('stripe'))
    @stripe_items = new StripeAdmin.Collections.StripeItems()
    @stripe_items = @stripe.get('stripe_items')

  new: ->
    @stripe_item = new StripeAdmin.Models.StripeItem()
    @stripe_items.add(@stripe_item)
    view = new StripeAdmin.Views.StripeItems(collection: @stripe_items)
    $('.new-stripe-container').empty()
    $('.new-stripe-container').html(view.render().el)
