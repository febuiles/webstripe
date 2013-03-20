class StripeAdmin.Views.Slides extends Backbone.View
  template: JST['admin/slides/slides']
  tagName: 'section'
  className: 'stripe'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendSlide, this)
    @collection.on('newSlide', @createSlide, this)
    @collection.on('drawNewLink', @drawNewLink, this)
    @collection.on('drawRemoveLink', @drawRemoveLink, this)


  render: ->
    $(@el).html(@template())
    @collection.each(@appendSlide)
    @

  appendSlide: (slide) =>
    view = new StripeAdmin.Views.Slide({model: slide, collection: @collection})
    @$('.slides').append(view.render().el)

  createSlide: ->
    @collection.add({stripe_id: "four"})

  drawNewLink: ->
    #@collection.last().trigger("drawLink")
    @collection.drawNewLink()

  drawRemoveLink: ->
    @collection.drawRemoveLink()

