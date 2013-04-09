class StripeAdmin.Views.StripeItems extends Support.CompositeView
  template: JST['admin/stripe_items/stripe']
  el: "<div class='stripe' id='stripe' />"

  events:
    'click .queue.add': 'addFirstStripeItem'
    'click .done-slide': 'saveStripe'

  initialize: ->
    @collection.on('reset', @renderSlides, this)
    @collection.on('add', @renderSingleSlide, this)
    @collection.on('render_slides', @renderSlides, this)

  render: ->
    console?.log 'Rendering Stripe#new'
    $(@el).html(@template())
    @renderSlides() if @collection.any()
    if @options.isFirstSlide
      @createStripeItem()
    @options.isFirstSlide = false
    @$(".stripe-box-bottom").show()
    @

  leave: ->
    @collection.off()
    console?.log 'Leaving Stripe#new'

  renderSlides: ->
    $(@el).find(".stripe-items").empty()
    @collection.each(@renderSingleSlide)

  renderSingleSlide: (stripe_item) =>
    view = new StripeAdmin.Views.StripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".stripe-items")

  renderShowSlides: ->
    $(@el).find(".stripe-items").empty()
    @collection.each(@renderSingleShowSlide)

  renderSingleShowSlide: (stripe_item) =>
    view = new StripeAdmin.Views.ShowStripeItem({model: stripe_item, collection: @collection})
    @appendChildTo(view, ".stripe-items")

  addStripeItem: (stripe_item) ->
    console?.log("Creating new stripe item", stripe_item)
    @collection.create stripe_item,
      silent: true
      while: true
      success: (stripe_item) =>
        @updateStripeView()
        @render()
        stripe_item.set({edit: true})

      error: ->
        @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  createSaveForm: ->
    @$(".stripe-box-bottom").hide()
    $(@el).find(".save-stripe").empty()
    stripe_item = @collection.first()
    stripe = stripe_item.get('stripe_id')
    view = new StripeAdmin.Views.SaveStripe({model: stripe})
    @appendChildTo(view,".save-stripe")

  updateStripeView: ->
    @children.each(@updateStripeItem)
    @children.each(@renderShow)

  addFirstStripeItem: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @createStripeItem()

  createStripeItem: ->
    stripe_item = new @collection.model()
    @addStripeItem(stripe_item)

  saveStripe: (e) ->
    e.preventDefault()

    @updateStripeView()
    @renderShowSlides()
    @createSaveForm()

  renderShow: (view) =>
    view.renderShow()

  updateStripeItem: (view) =>
    view.updateStripeItem()

  leave: ->
    @collection.off('reset', @renderSlides, this)
    @collection.off('add', @renderSingleSlide, this)
    @collection.off('render_slides', @renderSlides, this)