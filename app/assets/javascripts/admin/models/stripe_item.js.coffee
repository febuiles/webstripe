class StripeAdmin.Models.StripeItem extends Backbone.RelationalModel
  paramRoot: 'stripe_item'
  urlRoot: '/admin/stripe_items'

  drawNewLink: ->
    @trigger("drawLink")

  hideRemoveLink: ->
    @trigger("removeLink")

  showRemoveLink: ->
    @trigger("showLink")
