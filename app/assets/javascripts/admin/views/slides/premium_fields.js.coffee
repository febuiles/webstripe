class StripeAdmin.Views.PremiumFields extends Backbone.View
  template: JST['admin/stripe_items/premium_fields']
  el: "<div id='premium-fields' />"

  events:
    'click .upload-logo': 'uploadImage'
    'change #input-logo': 'submitImage'

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template(stripe: @model))
    this

  uploadImage: (e) ->
    e.preventDefault()
    @$("#input-logo").trigger('click')

  submitImage: ->
    image_file = @parent.$("form #input-logo")[0].files
    console.log image_file
    # TODO - Show loading
    if image_file.length > 0
      @parent.$("form").fileupload({ url: "/admin/stripes/" + @model.get('id') })
      @parent.$("form").fileupload('send', { files: image_file })
        .success((result, textStatus, jqXHR) =>
          # TODO - Hide loading
        ).error((jqXHR, textStatus, errorThrown) =>
        )

  savePremiumData: ->
    page_bg_color = $.trim(@$('#stripe-page-color').val())
    stripe_bg_color = $.trim(@$('#stripe-color').val())
    text_color = $.trim(@$('#stripe-text').val())
    fg_color = $.trim(@$('#stripe-link').val())
    company = $.trim(@$('#stripe-author').val())
    company_url = $.trim(@$('#stripe-url').val())

    attributes = {page_bg_color: page_bg_color, stripe_bg_color: stripe_bg_color, text_color: text_color, fg_color: fg_color, company: company, company_url: company_url}
    #console.log attributes
    # @parent.model.set(attributes)
    return attributes