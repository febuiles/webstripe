class StripeItem < ActiveRecord::Base
  belongs_to :stripe

  attr_accessible :content, :item_type, :stripe_id, :image

  mount_uploader :image, ImageUploader
end
