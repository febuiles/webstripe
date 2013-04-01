class StripeAdmin.Views.ShowStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/show_stripe_item']
  el: "<div class='stripe-item' />"

  events:
    'click': 'focusStripeItem'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('add_content', @addContent, this)

  render: ->
    $(@el).html(@template(stripe_item: @model))
      # attr('id', "stripe-item-#{@model.get('id')}").
      # addClass(@model.class()).
    this

  addContent: ->
    if (@model.get("item_type") is "image")
      content = $(document.createElement('img'))
      content.attr('src', @model.get('image')['url'])

    else if (@model.get("item_type") is "text")
      content = $(document.createElement('div'))
      content.attr('id', "content_text")
      content.prepend(@model.get("content"))

    # else if (@model.get("item_type") is "embed")
      # content = $(document.createElement('div'))
      # content.attr('id', "content_embed")
      # content.prepend($(@model.get("content")).text())

    @$("#content").prepend(content)

  focusStripeItem: (e) ->
    e.preventDefault()
    console?.log("Focusing on tool #{@model.get('id')} - #{@model.get('position')}")
    # TODO- implements what happens when is focused.

  leave: ->
    console.log "leave Show Stripe Item"
    @model.off("change", @render, this)
    @model.off("add_content", @add_content, this)
