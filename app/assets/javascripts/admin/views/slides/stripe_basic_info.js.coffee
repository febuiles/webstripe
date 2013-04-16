class StripeAdmin.Views.StripeBasicInfo extends Backbone.View
  template: JST['admin/stripe_items/stripe_basic_info']
  el: "<div class='stripe-basic-info' />"

  events:
    'change input:radio[name=alignment]' : 'showTooltipRadio'
    'click .basic-info-stripe-container': 'showTooltip'
    'blur #basic-info-stripe-container': 'saveStripe'
    'click .upload-logo': 'uploadImage'
    'change #input-logo': 'submitImage'

  initialize: ->
    @render()
    @role = @model.get('user')["role"]

  render: ->
    $(@el).html(@template(stripe: @model))
    @setStripeValues()
    @hideTooltip()
    @$("#premium-fields-container").hide()
    @renderPremiumFields()
    this

  setStripeValues: ->
    @$('input:radio[name=alignment][value=' + @model.get('alignment') + ']').prop("checked",true);

  renderPremiumFields: ->
    if not (@role is "basic")
      @$("#premium-fields-container").show()
      @$('.loading').hide()

  saveStripe: (e) ->
    e.preventDefault()
    title = $.trim(@$('.stripe-name-input').val())
    orientation = @$('input:radio[name=alignment]:checked').val()
    if ((title != '') and (orientation != ''))
      @model.unset("redirect")
      @model.unset("user")
      @setPremiumData()
      @model.set({title: title, alignment: orientation})
      if @model.hasChanged()
        @model.save()
        @hideTooltip()

  setPremiumData: ->
    if not (@role is "basic")
      page_bg_color = $.trim(@$('#stripe-page-color').val())
      stripe_bg_color = $.trim(@$('#stripe-color').val())
      text_color = $.trim(@$('#stripe-text').val())
      fg_color = $.trim(@$('#stripe-link').val())
      company = $.trim(@$('#stripe-author').val())
      company_url = $.trim(@$('#stripe-url').val())
      @model.set({page_bg_color: page_bg_color, stripe_bg_color: stripe_bg_color, text_color: text_color, fg_color: fg_color, company: company, company_url: company_url, title: "", alignment: ""})
    else
      {}

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response, responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  showTooltip: ->
    @$("#basic-info-tooltip").show()

  showTooltipRadio: ->
    @$("#basic-info-tooltip").show()
    @$('.stripe-name-input').focus()

  hideTooltip: ->
    @$("#basic-info-tooltip").hide()

  uploadImage: (e) ->
    e.preventDefault()
    @$("#input-logo").trigger('click')

  submitImage: ->
    image_file = @$("form #input-logo")[0].files
    @$('.loading').show()
    if image_file.length > 0
      @$("form").fileupload({ url: "/admin/stripes/" + @model.get('id') })
      @$("form").fileupload('send', { files: image_file })
        .success((result, textStatus, jqXHR) =>
          @$('.loading').hide()
        ).error((jqXHR, textStatus, errorThrown) =>
        )

  leave: ->
    @unbindFromAll();
    @remove()
