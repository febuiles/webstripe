class StripeAdmin.Views.StripeItem extends Backbone.View
  template: JST['admin/stripe_items/stripe_item']
  el: "<div class='stripe-item' id='stripe-item' />"

  events:
    'click .wrap-stripe-item-show': 'focusStripeItem'
    'click .queue.remove': 'removeSlide'
    'click .upload-image-stripe-item': 'uploadImage'
    'click .arrow-up' : 'moveUp'
    'click .arrow-down' : 'moveDown'
    'change #input-image-stripe-item': 'submitImage'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'blurHandler'

  initialize: ->
    @model.on('remove', @remove, this)
    @model.on('change', @render, this)
    @model.set({edit: false})
    @setPosition()

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
    if @model.get('edit') is true
      @renderEdit()
      @moveUpHandler()
    else
      @renderShow()
    @addContent()
    this

  moveUpHandler: ->
    index = @model.get('position')
    length = @collection.length

    if @model.isLastStripeItem(index, length)
      @$(".arrow-up").show()
      @$(".arrow-down").hide()

    if index is 0
      @$(".arrow-up").hide()
      @$(".arrow-down").show()
      if length is 1
        @$(".arrow-down").hide()

  renderEdit: ->
    @$(".wrap-stripe-item-show").hide()
    @$(".wrap-stripe-item-edit").show()
    @$(".loading").hide()
    @$(".stripe-input-content").css("background", "none")
    if (@model.get("item_type") is "image")
      @showImage()
    if (@model.get("content") is "" and @model.get("item_type") is "text")
      @$('.stripe-input-content').css("background", "url('/assets/stripeinputbg.png') top left no-repeat")

  renderShow: ->
    @$(".wrap-stripe-item-edit").hide()
    @$(".wrap-stripe-item-show").show()

  addContent: ->
    @$("#content").empty()
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
      embed = $(@model.get('content')).attr('width', "510")
      embed = embed.attr('height', "315")
      content.prepend(embed)

    @$("#content").prepend(content)

  focusStripeItem: (e) ->
    e.preventDefault()
    @parent.updateStripeView()
    @model.set({edit: true})

  removeSlide: (e) ->
    e.preventDefault()
    @model.destroy()
    @parent._removeChild(this)
    @collection.trigger("update_position")
    @parent.render()

  hideBg: ->
    @$('.stripe-input-content').focus ->
      $(this).css("background", "none")

  showBg: ->
    @$('.stripe-input-content').blur ->
      if ($.trim($(this).val()) == '')
        $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat")

  blurHandler: ->
    @showBg()

  uploadImage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @$('.stripe-input-content').val('')
    @$("#input-image-stripe-item").trigger('click')

  submitImage: ->
    image_file = @$("form #input-image-stripe-item")[0].files
    @$('.loading').show()
    if image_file.length > 0
      this.$("form").fileupload({ url: @collection.url + "/" + @model.get('id') })
      this.$("form").fileupload('send', { files: image_file })
        .success((result, textStatus, jqXHR) =>
          @model.set(result)
          @model.set({item_type: "image"})
          @model.set({content: ""})
          @model.unset("created_at", {silent: true})
          @model.unset("updated_at", {silent: true})
          @model.unset("edit", {silent: true})

          @showImage()
        ).error((jqXHR, textStatus, errorThrown) =>
          # @model.set({errors: $.parseJSON(jqXHR.responseText)})
        )

  showImage: ->
    @$('.loading').hide()
    @$('.stripe-input-content').attr("disabled","disabled");
    url_image = @model.get('image')['url']
    @$('.stripe-input-content').css("background", "url('"+url_image+"') center center no-repeat")

  setPosition: ->
    @model.unset("created_at", {silent: true})
    @model.unset("updated_at", {silent: true})
    @model.unset("edit", {silent: true})

    @model.set({position: @collection.indexOf(@model)})
    @model.save()

  updateStripeItem: ->
    if @model.get("item_type") is "image"
      @saveStripeItem(@model)
    else if @model.get("item_type") is "text" or @model.get("item_type") is "embed"
      if $.trim(@$('.stripe-input-content').val()) != ''
        attributes =
          content: $.trim(@$('.stripe-input-content').val())
        @model.set(attributes)
        @saveStripeItem(@model)
      else
        @model.destroy()
        @parent._removeChild(this)

  saveStripeItem: ->
    if @model.hasChanged()
      @model.unset("created_at", {silent: true})
      @model.unset("updated_at", {silent: true})
      @model.unset("edit", {silent: true})

      @model.save {},
        while: true
        success: (stripe_item) =>
          item_type = stripe_item.get('item_type')
          @model.set({item_type: item_type})

  moveUp: (e) ->
    e.preventDefault()
    index_a = @model.get('position')
    index_b = index_a - 1
    @collection.swapStripeItems(index_a, index_b)
    @parent.updateStripeView()
    @parent.render()
    @model.set({edit: true})

  moveDown: (e) ->
    e.preventDefault()
    index_a = @model.get('position')
    index_b = index_a + 1
    @collection.swapStripeItems(index_a, index_b)
    @parent.updateStripeView()
    @parent.render()
    @model.set({edit: true})

  leave: ->
    @unbindFromAll();
    @remove()
    @model.off('change', @render, this)
    @model.off('remove', @remove, this)
