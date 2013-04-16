class StripeAdmin.Views.StripeBasicInfo extends Support.CompositeView
  template: JST['admin/stripe_items/stripe_basic_info']
  el: "<div class='stripe-basic-info' />"

  events:
    'change input:radio[name=alignment]' : 'showTooltip'
    'keypress .stripe-name-input': 'showTooltip'
    'blur #basic-info-stripe-container': 'saveStripe'

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template(stripe: @model))
    @setStripeValues()
    @hideTooltip()
    # @renderPremiumFields()
    this

  setStripeValues: ->
    @$('input:radio[name=alignment][value=' + @model.get('alignment') + ']').prop("checked",true);

  renderPremiumFields: ->
    if not (@model.get('user')["role"] is "basic")
      console.log "Oh yeah!!"
      view = new StripeAdmin.Views.PremiumFields({model: @model})
      @appendChildTo(view, "#premium-fields-container")


  saveStripe: (e) ->
    e.preventDefault()
    title = $.trim(@$('.stripe-name-input').val())
    orientation = @$('input:radio[name=alignment]:checked').val()
    if ((title != '') and (orientation != ''))
      @model.unset("redirect", {silent: true})
      @model.set({title: title, alignment: orientation})
      if @model.hasChanged()
        @model.save()
        @hideTooltip()

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  showTooltip: ->
    @$("#basic-info-tooltip").show()
    @$('.stripe-name-input').focus()

  hideTooltip: ->
    @$("#basic-info-tooltip").hide()

  leave: ->
    @unbindFromAll();
    @remove()
