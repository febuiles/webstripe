class StripeAdmin.Views.StripeItem extends Backbone.View
  template: JST['admin/stripe_items/stripe_item']
  el: "<div class='stripe-item' id='stripe-item' />"

  events:
    'click .wrap-stripe-item-show': 'focusStripeItem'
    'click .queue.remove': 'deleteSlide'
    'click .upload-image-stripe-item': 'uploadImage'
    'click .put-upload-image-stripe-item': 'uploadImage'
    'click .arrow-up' : 'moveUp'
    'click .arrow-down' : 'moveDown'
    'change #input-image-stripe-item': 'submitImage'
    'click .switch-to-text-stripe-item': 'switchToText'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'blurHandler'

  initialize: ->
    @model.on('remove', @remove, this)
    @model.on('change', @render, this)
    @setPosition()
    @switched = false

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
    if @model.get('edit') is true
      @renderNewSlide()
    else
      @renderShow()
    @addContent()
    this

  arrowsRender: ->
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

  renderNewSlide: ->
    @cleanStripeItemView()
    @arrowsRender()
    if (@model.get("item_type") is "image")
      @showImage()
    if (@model.get("content") is "" and @model.get("item_type") is "text")
      @$('.stripe-input-content').css("background", "url('/assets/stripeinputbg.png') top left no-repeat")
    if (@model.get("item_type") is "embed")
      @showEmbed()

  renderShow: ->
    @$(".wrap-stripe-item-edit").hide()
    @$(".wrap-stripe-item-show").show()

  cleanStripeItemView: ->
    @$(".wrap-stripe-item-show").hide()
    @$(".wrap-stripe-item-edit").show()
    @$('.stripe-input-content').show()
    @$(".loading").hide()
    @$(".stripe-input-content").css("background", "none")
    @$('#container-image-links').hide()
    @$('#container-embed-links').hide()

  switchToText: (e) ->
    @moving = true
    e.preventDefault()
    @cleanStripeItemView()
    if @model.get("item_type") is "embed"
      @model.set({item_type:"text", image: null})
    else
      @model.set({item_type:"text", content:"", edited: true, image: null})
    @parent.updateStripeView()
    @model.set({edit: true})
    @switched = true
    @render()

  switchToTextFromEmbed: (item_type) ->
    if (item_type is "embed")
      @model.set({item_type:"text", image: null})
      @parent.updateStripeView() # over here
      @model.set({edit: true})
      @something = true
      @render()

  showLinksEditImage: ->
    @$('#container-new-links').hide()
    @$('#container-embed-links').hide()
    @$('#container-image-links').show()

  showLinksEditEmbed: ->
    @$('#container-new-links').hide()
    @$('#container-image-links').hide()
    @$('#container-embed-links').show()

  addContent: ->
    @$("#content").empty()
    if (@model.get("item_type") is "image")
      content = @addImageContent()
    else if (@model.get("item_type") is "text")
      content = @addTextContent()
    else if (@model.get("item_type") is "embed")
      content = @addEmbedContent()
    @$("#content").prepend(content)

  addImageContent: ->
    content = $(document.createElement('img'))
    content.attr('src', @model.get('image')['url'])

  addTextContent: ->
    content = $(document.createElement('div'))
    content.attr('id', "content_text")
    content.prepend(@model.get("content"))

  addEmbedContent: ->
    content = $(document.createElement('div'))
    content.attr('id', "content_embed")
    embed = $(@model.get('content')).attr('width', "510")
    embed = embed.attr('height', "315")
    content.prepend(embed)

  focusStripeItem: (e) ->
    e.preventDefault()
    @parent.updateStripeView()
    @model.set({edit: true})
    @render()

  deleteSlide: (e) ->
    e.preventDefault()
    @removeSlide()

  removeSlide: ->
    @model.destroy()
    @parent._removeChild(this)
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
    @$('.stripe-input-content').val('')
    @$("#input-image-stripe-item").trigger('click')

  submitImage: ->
    image_file = @$("form #input-image-stripe-item")[0].files
    @$('.loading').show()
    if image_file.length > 0
      this.$("form").fileupload({ url: @collection.url + "/" + @model.get('id') })
      this.$("form").fileupload('send', { files: image_file })
        .success((result, textStatus, jqXHR) =>
          @model.afterSaveImage(result)
          @saveStripeItemWithImage()
        ).error((jqXHR, textStatus, errorThrown) =>
          # @model.set({errors: $.parseJSON(jqXHR.responseText)})
        )

  showImage: ->
    @cleanStripeItemView()
    @$('.stripe-input-content').attr("disabled","disabled");
    url_image = @model.get('image')['url']
    @$('.stripe-input-content').css("background", "url('"+url_image+"') center center no-repeat")
    @showLinksEditImage()

  showEmbed: ->
    @cleanStripeItemView()
    embed = @model.get('content')
    embed_html = $(embed)

    if embed_html.find("img").attr("src")?
      @showPinterestEmbed(embed_html)
    else
      embed = $(@model.get('content')).attr('width', "412")
      embed = embed.attr('height', "270")
      @$("#embed_content").append(embed)

    @$('.stripe-input-content').hide()
    @showLinksEditEmbed()

  showPinterestEmbed: (embed_html) =>
    url_image = embed_html.find("img").attr("src")
    @$('.stripe-input').css("background", "url('"+url_image+"') center center no-repeat")

  setPosition: ->
    @model.setPosition()
    if @model.hasChanged()
      @model.save()

  updateStripeItem: ->
    if @model.get("item_type") is "image"
      @saveStripeItem(@model)
    else if @model.get("item_type") is "text" or @model.get("item_type") is "embed"
      @updateStripItemText()

  updateStripItemText: ->
    if $.trim(@$('.stripe-input-content').val()) != ''
      attributes =
        content: $.trim(@$('.stripe-input-content').val())
      @model.set(attributes)
      @saveStripeItem(@model)
    else if (not @moving? and not @model.get('edited')?)
      @removeSlide()

  saveStripeItem: ->
    if @model.hasChanged() or @switched
      @model.beforeSave()
      @model.save {},
        while: true
        success: (stripe_item) =>
          @model.afterSaveStripeItem(stripe_item)
          @switched = false

  saveStripeItemWithImage: ->
    if @model.hasChanged()
      @model.save {},
        while: true
        success: (stripe_item) =>
          @model.set({edit: true})

  moveUp: (e) ->
    @moving = true
    e.preventDefault()
    index_a = @model.get('position')
    index_b = index_a - 1
    @collection.swapStripeItems(index_a, index_b)
    @parent.updateStripeView()
    @parent.render()
    @model.set({edit: true})
    @render()

  moveDown: (e) ->
    @moving = true
    e.preventDefault()
    index_a = @model.get('position')
    index_b = index_a + 1
    @collection.swapStripeItems(index_a, index_b)
    @parent.updateStripeView()
    @parent.render()
    @model.set({edit: true})
    @render()

  leave: ->
    @unbindFromAll();
    @remove()
    @model.off('change', @render, this)
    @model.off('remove', @remove, this)
