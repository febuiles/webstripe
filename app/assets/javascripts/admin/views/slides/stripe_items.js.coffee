class StripeAdmin.Views.StripeItems extends Backbone.View
  template: JST['admin/slides/slides']
  tagName: 'section'
  className: 'stripe'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendSlide, this)
    @collection.on('newSlide', @createSlide, this)
    @collection.on('drawNewLink', @drawNewLink, this)
    @collection.on('drawRemoveLink', @drawRemoveLink, this)
    @collection.on('slideSaveIt', @updateView, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendSlide)
    @

  appendSlide: (stripe_item) =>
    view = new StripeAdmin.Views.StripeItem({model: stripe_item, collection: @collection})
    @$('.slides').append(view.render().el)

  createSlide: ->
    @collection.add({position: "4"})

  drawNewLink: ->
    @collection.drawNewLink()

  drawRemoveLink: ->
    @collection.drawRemoveLink()

  updateView: ->
    @collection.updateView()