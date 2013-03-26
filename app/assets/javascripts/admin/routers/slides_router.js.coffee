class StripeAdmin.Routers.Slides extends Backbone.Router
  routes:
    'admin/stripes/new': 'new'

  initialize: ->
    @slide = new StripeAdmin.Models.Slide({stripe_id: "one"})

  new: ->
    view = new StripeAdmin.Views.Slide(model: @slide)
    $('#container').html(view.render().el)