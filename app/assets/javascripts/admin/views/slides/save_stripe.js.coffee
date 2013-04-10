class StripeAdmin.Views.SaveStripe extends Support.CompositeView
  template: JST['admin/stripe_items/save_stripe']
  el: "<div class='save-stripe' />"

  events:
    'click .done-button': 'saveStripe'
    'click .back-to-editor': 'backToEditor'

  render: ->
    console.log "render save stripe"
    $(@el).html(@template())
    this

  saveStripe: (e) ->
    e.preventDefault()
    title = $.trim(@$('.stripe-name-input').val())
    orientation = @$('input:radio[name=alignment]:checked').val()

    if ((title != '') and (orientation != ''))
      @model.save {state: "published", title: title, alignment: orientation},
        silent: true
        while: true
        success: (stripe) =>
          if stripe.get('redirect')
            window.location = stripe.get('redirect')
        error: ->
          @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  backToEditor: (e) ->
    e.preventDefault()
    @parent._removeChild(this)
    @parent.render()
    @parent.createStripeItem()

  leave: ->
    @remove()