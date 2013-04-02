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
    $(@el).find(".save-stripe").empty()
    stripe_item = new @collection.model()
    view = new StripeAdmin.Views.NewStripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".new-stripe-item")

  addStripeItem: (stripe_item, isDone) ->
    console?.log("Creating new stripe item", stripe_item)
    @collection.create stripe_item,
      silent: true
      while: true
      success: (stripe_item) =>
        @renderSingleSlide(stripe_item)
        if not isDone
          @createNewSlideForm()
        else
          @createSaveForm()
        stripe_item.trigger("add_content")
      error: ->
        @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  createSaveForm: ->
    $(@el).find(".new-stripe-item").empty()
    $(@el).find(".save-stripe").empty()
    stripe_item = @collection.first()
    stripe = stripe_item.get('stripe_id')
    view = new StripeAdmin.Views.SaveStripe({model: stripe})
    @appendChildTo(view,".save-stripe")

  leave: ->
    @collection.off('reset', @renderSlides, this)
    @collection.off('add', @renderSingleSlide, this)