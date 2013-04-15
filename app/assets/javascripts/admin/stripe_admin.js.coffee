window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @router = new StripeAdmin.Routers.Stripe()
    Backbone.history.start(pushState: true)

$(document).ready ->
  StripeAdmin.initialize()