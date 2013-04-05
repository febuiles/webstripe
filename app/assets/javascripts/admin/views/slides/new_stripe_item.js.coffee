class StripeAdmin.Views.NewStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/new_stripe_item']
  el: "<div class='section new' id='new-stripe-item'/>"

  events:
    'click .queue.add': 'createStripeItem'
    'click .queue.remove': 'removeSlide'
    'click .done-slide': 'saveStripe'
    'click .upload-image-stripe-item': 'uploadImage'
    'change #input-image-stripe-item': 'submitImage'


    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'blurHandler'

  initialize: ->
    @collection.on('update_position', @render, this)

  render: ->
    $(@el).html @template(position: @collection.length + 1)
    @$(".loading").hide()
    this

  createStripeItem: (e) ->
    e.preventDefault()
    @addStripeItem(false)

  removeSlide: (e) ->
    e.preventDefault()
    $(@el).find("#new_stripe_item")[0].reset()

  hideBg: ->
    @$('.stripe-input-content').focus ->
      $(this).css("background", "none")

  showBg: ->
    @$('.stripe-input-content').blur ->
      if ($.trim($(this).val()) == '')
        $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat")

  saveStripe: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @addStripeItem(true)

  blurHandler: ->
    @showBg()

  addStripeItem: (isDone) ->
    if @model.get("item_type") is "image"
      @parent.addStripeItem(@model, isDone)
    else if @model.get("item_type") is "text"
      if $.trim(@$('.stripe-input-content').val()) != ''
        attributes =
          position: @collection.length + 1
          content: $.trim(@$('.stripe-input-content').val())
        @model.set(attributes)
        @parent.addStripeItem(@model, isDone)

  uploadImage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(@el).find("#new_stripe_item")[0].reset()
    @$("#input-image-stripe-item").trigger('click')

  submitImage: ->
    image_file = @$("form #input-image-stripe-item")[0].files
    @$('.loading').show()
    if image_file.length > 0
      this.$("form").fileupload({ url: @collection.url })
      this.$("form").fileupload('send', { files: image_file })
        .success((result, textStatus, jqXHR) =>
          @model.set(result)
          @model.set({item_type: "image", position: @collection.length + 1})
          @model.unset("created_at", {silent: true})
          @model.unset("updated_at", {silent: true})

          @showImage()
        ).error((jqXHR, textStatus, errorThrown) =>
          # @model.set({errors: $.parseJSON(jqXHR.responseText)})
        )

  showImage: ->
    @$('.loading').hide()
    @$('.stripe-input-content').attr("disabled","disabled");
    url_image = @model.get('image')['url']
    @$('.stripe-input-content').css("background", "url('"+url_image+"') center center no-repeat")

  renderShow: ->
    console.log "hola"

  updateStripeItem: ->
    console.log "hola save stripe item"

  leave: ->
    @collection.off('update_position', @render, this)
    @remove()
