class StripeAdmin.Collections.Slides extends Backbone.Collection
  url: '/admin/stripes/:id'
  model: StripeAdmin.Models.Slide

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

