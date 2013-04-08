class StripeAdmin.Views.ShowStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/show_stripe_item']
  el: "<div class='stripe-item' />"

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
    @addContent()
    this

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
      embed = $(@model.get('content')).attr('width', "510")
      embed = embed.attr('height', "315")
      content.prepend(embed)
      console.log "is embed"

    @$("#content").prepend(content)

  renderShow: ->

  updateStripeItem: ->

  leave: ->
    $(@el).off()
    @model.off("change", @render, this)
