class StripeAdmin.Views.ShowStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/show_stripe_item']
  el: "<div class='stripe-item' />"

  events:
    'click': 'focusStripeItem'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('add_content', @addContent, this)

  render: ->
    $(@el).html(@template({stripe_item: @model, position: @model.get('position')}))
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

  focusStripeItem: (e) ->
    e.preventDefault()
    console?.log("Focusing on stripe_item #{@model.get('id')} - #{@model.get('position')}")
    edit_view = new StripeAdmin.Views.EditStripeItem({model: @model, collection: @collection})
    @leave()
    $(@el).empty()
    $(@el).append(edit_view.render().el)

  leave: ->
    $(@el).off()
    @model.off("change", @render, this)
    @model.off("add_content", @add_content, this)
