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
    #return attributes