#= require ./stripe_item
class StripeAdmin.Views.EditStripeItem extends StripeAdmin.Views.StripeItem

  events: ->
    _.extend {}, StripeAdmin.Views.StripeItem.prototype.events,
      'change #stripe-input-content': 'tooltip'

  render: ->
    super
    @addTooltip()
    @

  tooltip: ->
    @$("#edit-tooltip").show()

  addTooltip: ->
    content = $(document.createElement('div'))
    content.attr('id', "edit-tooltip")
    content.attr('class', "arrow-box-right")
    content.text('To save changes and go back to the editor, simply click outside this slide')
    @$("#wrap-stripe-item-edit").prepend(content)
    @$("#edit-tooltip").hide()
