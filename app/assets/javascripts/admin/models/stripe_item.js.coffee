class StripeAdmin.Models.StripeItem extends Backbone.RelationalModel
  paramRoot: 'stripe_item'
  urlRoot: '/admin/stripe_items'

  defaults:
    position: "1"
    item_type: "text"

  drawNewLink: ->
    @trigger("drawLink")

  hideRemoveLink: ->
    @trigger("removeLink")

  showRemoveLink: ->
    @trigger("showLink")
