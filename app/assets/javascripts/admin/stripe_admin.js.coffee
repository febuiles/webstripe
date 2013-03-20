window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    new StripeAdmin.Routers.Slides()
    Backbone.history.start(pushState: true)

$(document).ready ->
  StripeAdmin.initialize()