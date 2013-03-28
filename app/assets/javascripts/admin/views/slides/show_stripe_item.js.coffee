class StripeAdmin.Views.ShowStripeItem extends Backbone.View
  template: JST['admin/stripe_items/show_stripe_item']
  el: "<div class='stripe-item' />"

  events:
    'click': 'focusStripeItem'

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(stripe_item: @model))
      # attr('id', "stripe-item-#{@model.get('id')}").
      # addClass(@model.class()).

    this

  focusStripeItem: (e) ->
    e.preventDefault()
    console?.log("Focusing on tool #{@model.get('id')} - #{@model.get('position')}")
    # TODO- implements what happens when is focused.

  leave: ->
    @model.off("change", @render, this)
