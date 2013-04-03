class StripeAdmin.Views.StripeItem extends Backbone.View
  template: JST['admin/stripe_items/stripe_item']
  el: "<div class='stripe-item' id='stripe-item' />"

  events:
    'click .wrap-stripe-item-show': 'focusStripeItem'
    'click .queue.remove': 'removeSlide'
    'click .upload-image-stripe-item': 'uploadImage'
    'change #input-image-stripe-item': 'submitImage'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'blurHandler'

  initialize: ->
    @model.on('remove', @remove, this)
    @setPosition()

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
    @renderShow()
    @addContent()
    @setPosition()
    this

  renderEdit: ->
    @$(".wrap-stripe-item-show").hide()
    @$(".wrap-stripe-item-edit").show()
    @$(".loading").hide()
    @$(".stripe-input-content").css("background", "none")

  renderShow: ->
    @$(".wrap-stripe-item-edit").hide()
    @$(".wrap-stripe-item-show").show()

  addContent: ->
    if (@model.get("item_type") is "image")
      content = $(document.createElement('img'))
      content.attr('src', @model.get('image')['url'])

    else if (@model.get("item_type") is "text")
      content = $(document.createElement('div'))
      content.attr('id', "content_text")
      content.prepend(@model.get("content"))

    else if (@model.get("item_type") is "embed")
      content = $(document.createElement('div'))
      content.attr('id', "content_embed")
      embed = $(@model.get('content')).attr('width', "530")
      embed = embed.attr('height', "315")
      content.prepend(embed)
      console.log "is embed"

    @$("#content").prepend(content)

  focusStripeItem: (e) ->
    e.preventDefault()
    console.log "focus stripe item"
    @renderEdit()

  removeSlide: (e) ->
    e.preventDefault()
    @model.destroy()
    @collection.trigger("update_position")
    @collection.trigger("something")

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
          # position: @collection.length + 1
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
          @model.set({item_type: "image"})
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

  setPosition: ->
    @model.unset("created_at", {silent: true})
    @model.unset("updated_at", {silent: true})
    @model.set({position: @collection.indexOf(@model)})
    @model.save()

  leave: ->
    @model.off('remove', @remove, this)
