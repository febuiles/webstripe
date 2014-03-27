window.Webstripe = {}

Webstripe.load = (stripe_id, container) ->
  console.log("Container does not exist: #{container}") unless $(container)?
  Webstripe.stripe_id = stripe_id
  Webstripe.container = $(container)
  url = "http://webstripe.co/stripes/#{stripe_id}.json"

  Webstripe.setupContainer()
  $.get(url, Webstripe.setupStripe)

Webstripe.setupContainer = ->
  container = Webstripe.container
  container.css("text-align", "center")
  Webstripe.containerCenter = container[0].offsetLeft + (container.width() * 0.5)
  Webstripe.itemContainerWidth = "720"

Webstripe.setupStripe = (data) ->
  stripe = data.stripe
  Webstripe.stripe = stripe
  Webstripe.createItemContainer("##{stripe.stripe_bg_color}", "##{stripe.text_color}")
  Webstripe.container.css("background-color", "##{stripe.page_bg_color}")
  $.map(stripe.stripe_items, Webstripe.addStripeItem)

Webstripe.addStripeItem = (item) ->
  stripe_container = Webstripe.stripe_container.clone()
  stripe_container.append(Webstripe.getItemHTML(item))
  if item.position % 2 == 0
    stripe_container.css("left", "#{Webstripe.findCenter() + 20}px")
  else
    stripe_container.css("left", "#{Webstripe.findCenter() - 20}px")
  Webstripe.container.append(stripe_container)

Webstripe.findCenter = ->
    Webstripe.containerCenter - Webstripe.itemContainerWidth

Webstripe.createItemContainer = (bg_color, fg_color) ->
  container = $("<div>")
  container.css("background-color", bg_color)
  container.css("border-color", bg_color)
  container.css("color", fg_color)
  container.css("border-width", "15px")
  container.css("max-width", "720px")
  container.css("font-size", "24px")
  container.css("position", "relative")
  Webstripe.stripe_container = container;

Webstripe.getItemHTML = (item) ->
  if item.item_type == "image"
    $("<img>").attr("src", item.image.image.url).css("max-width", "600px")
  else if item.item_type == "embed"
    item.content
  else
    p = $("<p style='text-align: left; padding: 15px'>").text(item.content)
    p.css("-webkit-margin-before", "0");
    p.css("-webkit-margin-after", "0");
