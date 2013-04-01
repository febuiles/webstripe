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
    view = new StripeAdmin.Views.ShowStripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".stripe-items")

  renderSlides: ->
    $(@el).find(".stripe-items").empty()
    @collection.each(@renderSingleSlide)

  createNewSlideForm: ->
    $(@el).find(".new-stripe-item").empty()
    stripe_item = new @collection.model()
    view = new StripeAdmin.Views.NewStripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".new-stripe-item")

  addStripeItem: (stripeItemAttributes) ->
    console?.log("Creating new stripe item", stripeItemAttributes)
    @collection.create stripeItemAttributes,
      silent: true
      while: true
      success: (stripe_item) =>
        @renderSingleSlide(stripe_item)
        stripe_item.trigger("add_content")
        @collection.trigger("update_position")
        @createNewSlideForm()
      error: ->
        @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages