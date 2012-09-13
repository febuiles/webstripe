class StripeItem < ActiveRecord::Base
  belongs_to :stripe

  attr_accessible :content, :item_type, :stripe_id, :image

  mount_uploader :image, ImageUploader

  def text?
    item_type == "text"
  end

  def embed?
    item_type == "embed"
  end

  def image?
    item_type == "image"
  end
end
