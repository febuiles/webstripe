class StripeItem < ActiveRecord::Base
  belongs_to :stripe

  attr_accessible :content, :item_type, :stripe_id, :image, :_destroy, :position
  attr_accessor :_destroy

  after_validation :update_stripe_item

  mount_uploader :image, ImageUploader

  default_scope order("position ASC")

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

  def update_stripe_item
    if (item_type == "text")
      doc = Nokogiri::HTML(content)
      update_item_type(doc)
    end
  end

  def update_item_type(doc)
    if (not(doc.xpath("//iframe").empty? and doc.xpath("//embed").empty? and doc.xpath("//blockquote").empty? and doc.xpath("//div").empty?))
      self.item_type = "embed"
      update_embed_content(doc)
    end
 end

  def update_embed_content(doc)
    if(not doc.xpath("//iframe").empty?)
      self.content = doc.xpath("//iframe").first.to_html
    elsif(not doc.xpath("//embed").empty?)
      self.content = doc.xpath("//embed").first.to_html
    end
  end
end
