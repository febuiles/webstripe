json.stripe do |stripe|
  stripe.(@stripe, :id, :title, :alignment, :page_bg_color, :stripe_bg_color, :fg_color, :text_color)
  stripe.stripe_items @stripe.stripe_items, :item_type, :content, :image, :position
end
