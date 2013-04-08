window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    console?.log "StripeAdmin initialization point"

    @router = new StripeAdmin.Routers.Stripe()
    Backbone.history.start(pushState: true)

$(document).ready ->
  StripeAdmin.initialize()