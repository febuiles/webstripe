class StripeItem < ActiveRecord::Base
  belongs_to :stripe

  attr_accessible :content, :item_type, :stripe_id, :image, :_destroy, :position
  attr_accessor :_destroy

  after_validation :update_item_type

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

  private

  def update_item_type
    if (item_type == "text")
      doc = Nokogiri::HTML(content)
      if (not(doc.xpath("//iframe").empty? and doc.xpath("//embed").empty?))
        self.item_type = "embed"
      end
    end
  end
end
