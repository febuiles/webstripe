window.StripeAdmin =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @router = new StripeAdmin.Routers.Stripe()
    # FIX remove pushState for older browsers
    # author Glauber Portella <glauber.portella_at_gmail.com>
    @enablePushState = true
    @pushState = !!(enablePushState && window.history && window.history.pushState)
    Backbone.history.start(pushState: @pushState)

$(document).ready ->
  StripeAdmin.initialize()