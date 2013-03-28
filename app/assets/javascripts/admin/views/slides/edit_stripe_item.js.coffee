class StripeAdmin.Views.EditStripeItem extends Backbone.View
  template: JST['admin/stripe_items/slide']
  tagName:'div'

  events:
    'click .queue.add': 'newSlide'
    'click .queue.remove': 'removeSlide'
    'click .done-slide': 'saveStripe'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'showBg'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('remove', @remove, this)
    @model.on('drawLink', @drawNewLink, this)
    @model.on('removeLink', @hideRemoveLink, this)
    @model.on('showLink', @showRemoveLink, this)

  render: ->
    $(@el).html(@template(stripe_item: @model))
    @collection.trigger('drawNewLink')
    @collection.trigger('drawRemoveLink')
    this

  newSlide: (event) ->
    event.preventDefault()
    event.stopPropagation()

    if $.trim(@$('.stripe-input-content').val()) != ''
      @model.unset("errors")
      @model.set('content', $.trim(@$('.stripe-input-content').val()))
      @collection.create(@model,
        success: (stripe_item) =>
          console.log "Success"
          view = new StripeAdmin.Views.ShowStripeItem({model: stripe_item})
          $(@el).parent().prev().find('.stripe').append(view.render().el)

        # TODO - Show errors.
        error: (stripe_item, jqXHR) =>
          @model.set({errors: $.parseJSON(jqXHR.responseText)})
      )

    @collection.trigger('newSlide')

  removeSlide: (event) ->
    event.preventDefault()
    @collection.remove(@model)
    @model.destroy()
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

  saveStripe: (event) ->
    event.preventDefault()
    event.stopPropagation()

    if $.trim(@$('.stripe-input-content').val()) != ''
      @model.unset("errors")
      @model.set('content', $.trim(@$('.stripe-input-content').val()))
      @collection.create(@model,
        success: (stripe_item) =>
          console.log "Success"

        # TODO - Show errors.
        error: (stripe_item, jqXHR) =>
          @model.set({errors: $.parseJSON(jqXHR.responseText)})
      )