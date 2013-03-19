window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  sanity :->
    alert "juaaaa"
    true

  initialize: ->
    new StripeAdmin.Routers.Slides()
    Backbone.history.start(pushState: true)

$(document).ready ->
  StripeAdmin.initialize()