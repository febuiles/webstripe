window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @router = new StripeAdmin.Routers.Stripe()
    @enablePushState = true
    @pushState = !!(@enablePushState && window.history && window.history.pushState)
    Backbone.history.start(pushState: @pushState)

$(document).ready ->
  StripeAdmin.initialize()
