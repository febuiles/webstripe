class StripeAdmin.Views.Slide extends Backbone.View
  template: JST['admin/slides/slide']
  tagName:'li'

  events:
    'click .queue.add': 'newSlide'
    'click .queue.remove': 'removeSlide'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('remove', @remove, this)
    @model.on('drawLink', @drawNewLink, this)
    @model.on('removeLink', @hideRemoveLink, this)
    @model.on('showLink', @showRemoveLink, this)

  render: ->
    $(@el).html(@template(slide: @model))
    @collection.trigger('drawNewLink')
    @collection.trigger('drawRemoveLink')
    this

  newSlide: (event) ->
    event.preventDefault()
    @collection.trigger('newSlide', @model)

  removeSlide: (event) ->
    event.preventDefault()
    @collection.remove(@model)
    @collection.trigger('drawNewLink')
    @collection.trigger('drawRemoveLink')

  drawNewLink: ->
    $('.queue.add').hide()
    @$('.queue.add').show()

  hideRemoveLink: ->
    @$('.queue.remove').hide()

  showRemoveLink: ->
    @$('.queue.remove').show()