class StripeAdmin.Views.Slide extends Backbone.View
  template: JST['admin/slides/slide']
  tagName:'div'

  events:
    'click .queue.add': 'newSlide'
    'click .queue.remove': 'removeSlide'
    'focus .stripe-input-content': 'hideBg' 
    'blur .stripe-input-content': 'showBg'

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

  hideBg: ->
    @$('.stripe-input-content').focus -> 
      $(this).css("background", "none")

  showBg: ->
    @$('.stripe-input-content').blur ->
      if ($.trim($(this).val()) == '')
        $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat")
 