class StripeAdmin.Views.ShowStripeItem extends Backbone.View
  template: JST['admin/slides/show_slide']

  initialize: ->

  render: ->
    $(@el).html(@template(stripe_item: @model))
    @