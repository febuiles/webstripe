class StripeAdmin.Routers.Slides extends Backbone.Router
  routes:
    'admin/stripes/new': 'new'

  initialize: ->
    @slides = new StripeAdmin.Collections.Slides([{stripe_id: "one"}])

  new: ->
    view = new StripeAdmin.Views.Slides(collection: @slides)
    $('#container').empty()
    $('#container').html(view.render().el)
