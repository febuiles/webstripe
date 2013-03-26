class StripeAdmin.Views.Slide extends Backbone.View
  template: JST['admin/slides/slide']
  tagName:'li'

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(slide: @model))
    this