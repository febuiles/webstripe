class StripeAdmin.Views.NewStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/new_stripe_item']
  el: "<div class='section new' id='new-stripe-item'/>"

  events:
    'click .queue.add': 'createStripeItem'
    'click .queue.remove': 'removeSlide'
    'click .done-slide': 'saveStripe'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'showBg'

  initialize: ->
    @collection.on('update_position', @render, this)

  render: ->
    $(@el).html @template(position: @collection.length + 1)
    this

  createStripeItem: (e) ->
    e.preventDefault()

    if $.trim($('.stripe-input-content').val()) != ''
      attributes =
        position: @collection.length + 1
        content: $.trim($('.stripe-input-content').val())
        item_type: "text"
        # TODO - implement set item type

      @parent.addStripeItem(attributes)
      $(@el).find("#new_stripe_item")[0].reset()

  removeSlide: (e) ->
    e.preventDefault()
    $(@el).find("#new_stripe_item")[0].reset()

  hideBg: ->
    $('.stripe-input-content').focus ->
      $(this).css("background", "none")

  showBg: ->
    @$('.stripe-input-content').blur ->
      if ($.trim($(this).val()) == '')
        $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat")

  saveStripe: ->
    console?.log "Set stripe on published status"

  leave: ->
    console.log "leave Show Stripe Item"
    @collection.off("update_position", @render, this)