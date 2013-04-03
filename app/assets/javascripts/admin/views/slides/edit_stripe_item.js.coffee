class StripeAdmin.Views.EditStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/edit_stripe_item']
  el: "<div class='section new' id='new-stripe-item'/>"

  events:
    'click .queue.remove': 'removeSlide'
    'click .upload-image-stripe-item': 'uploadImage'
    'change #input-image-stripe-item': 'submitImage'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'blurHandler'

  initialize: ->

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
    @$(".loading").hide()
    @$('.stripe-input-content').css("background", "none")
    this

  removeSlide: (e) ->
    e.preventDefault()
    @model.destroy()
    @leave()

  hideBg: ->
    @$('.stripe-input-content').focus ->
      $(this).css("background", "none")

  showBg: ->
    @$('.stripe-input-content').blur ->
      if ($.trim($(this).val()) == '')
        $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat")

  blurHandler: ->
    @showBg()

  addStripeItem: ->
    if @model.get("item_type") is "image"
      @parent.addStripeItem(@model)
    else if @model.get("item_type") is "text"
      if $.trim($('.stripe-input-content').val()) != ''
        attributes =
          position: @collection.length + 1
          content: $.trim($('.stripe-input-content').val())
        @model.set(attributes)
        @parent.addStripeItem(@model)

  uploadImage: (e) ->
    e.preventDefault()
    e.stopPropagation()
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
    @$('.stripe-input-content').css("background", "url('"+url_image+"') top left no-repeat")

  leave: ->
    @unbindFromAll()
    @remove()