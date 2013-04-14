#= require ./stripe_items
class StripeAdmin.Views.EditStripeItems extends StripeAdmin.Views.StripeItems

  initialize: ->
    super
    @render()

  render: ->
    super
    @renderStripeBasicInfo()
    @

  renderSingleSlide: (stripe_item) =>
    view = new StripeAdmin.Views.EditStripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".stripe-items")

  renderStripeBasicInfo: ->
    console.log "render basic info"
    $(@el).find(".stripe-basic-data").empty()
    stripe_item = @collection.first()
    stripe = stripe_item.get('stripe_id')
    view = new StripeAdmin.Views.StripeBasicInfo({model: stripe})
    @$(".stripe-basic-data").append(view.el)