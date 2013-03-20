class StripeAdmin.Models.Slide extends Backbone.Model
  defaults:
    'position':1

  drawNewLink: ->
    @trigger("drawLink")

  hideRemoveLink: ->
    @trigger("removeLink")

  showRemoveLink: ->
    @trigger("showLink")
