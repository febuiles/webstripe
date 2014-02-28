class StripeAdmin.Routers.Stripe extends Support.SwappingRouter
  routes:
    'admin/stripes/new': 'new'
    'admin/stripes/:id/edit': 'edit'

  initialize: ->
    @stripe = new StripeAdmin.Models.Stripe($('#stripe_items_data').data('stripe'))
    @stripe_items = new StripeAdmin.Collections.StripeItems()
    @stripe_items = @stripe.get('stripe_items')

  new: ->
    @el = $("div.new-stripe-container")
    @swap(new StripeAdmin.Views.StripeItems({collection: @stripe_items, isEmptySlide: true}))

  edit: (id) ->
    @el = $("div.edit-stripe-container")
    @swap(new StripeAdmin.Views.EditStripeItems({collection: @stripe_items, isEmptySlide: false}))