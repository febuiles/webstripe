class StripeAdmin.Views.NewStripeItem extends Support.CompositeView
  template: JST['admin/stripe_items/new_stripe_item']
  el: "<div class='section new' id='new-stripe-item'/>"

  events:
    'click .queue.add': 'createStripeItem'
    'click .queue.remove': 'removeSlide'
    'click .done-slide': 'saveStripe'

    'focus .stripe-input-content': 'hideBg'
    'blur .stripe-input-content': 'showBg'

  render: ->
    console?.log("Rendering new stripe item")
    $(@el).html @template()
    this

  createStripeItem: (e) ->
    e.preventDefault()

    if $.trim($('.stripe-input-content').val()) != ''
      attributes =
        # TODO - improve set position
        position: "1"
        content: $.trim($('.stripe-input-content').val())
        # TODO - implement set item type
        item_type: "text"

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