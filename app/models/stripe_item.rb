class StripeItem < ActiveRecord::Base
  belongs_to :stripe

  attr_accessible :content, :item_type, :stripe_id, :image, :_destroy
  attr_accessor :_destroy

  mount_uploader :image, ImageUploader

  default_scope order("created_at ASC")

  def text?
    item_type == "text"
  end

  def embed?
    item_type == "embed"
  end

  def image?
    item_type == "image"
  end

  def invalid?
    content.blank? and image.blank?
  end
end
