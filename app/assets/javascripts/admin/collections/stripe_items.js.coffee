class StripeAdmin.Collections.StripeItems extends Backbone.Collection
  model: StripeAdmin.Models.StripeItem
  url: '/admin/stripe_items'

  isFirstSlide: (index) ->
    return (index == 0)

  isLastSlide: (index) ->
    return (index == (@models.length - 1))

  drawNewLink: ->
    @last().drawNewLink()

  drawRemoveLink: ->
    if @models.length > 1
      @first().showRemoveLink()
    else
      @first().hideRemoveLink()

