class StripeAdmin.Views.StripeItems extends Support.CompositeView
  template: JST['admin/stripe_items/stripe']
  el: "<div class='stripe' id='stripe-new' />"

  initialize: ->
    @collection.on('reset', @renderSlides, this)
    @collection.on('add', @renderSingleSlide, this)

  render: ->
    console?.log 'Rendering Stripe#new'
    $(@el).html(@template())
    @renderSlides() if @collection.any()
    @createNewSlideForm()
    @

  leave: ->
    @collection.off()
    console?.log 'Leaving Stripe#new'

  renderSingleSlide: (stripe_item) =>
    view = new StripeAdmin.Views.ShowStripeItem({model: stripe_item})
    @appendChildTo(view, ".stripe-items")

  renderSlides: ->
    $(@el).find(".stripe-items").empty()
    @collection.each(@renderSingleSlide)

  createNewSlideForm: ->
    view = new StripeAdmin.Views.NewStripeItem()
    @appendChildTo(view, ".new-stripe-item")

  addStripeItem: (stripeItemAttributes) ->
    console?.log("Creating new stripe item", stripeItemAttributes)
    @collection.create stripeItemAttributes,
      success: (stripe_item) =>
      error: ->
        @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages