class Stripe < ActiveRecord::Base
  has_many :stripe_items, :dependent => :destroy
  belongs_to :user

  attr_protected :id

  before_save :set_title

  mount_uploader :company_logo, ImageUploader

  default_scope order("state, updated_at DESC")

  accepts_nested_attributes_for :stripe_items,
                                :reject_if => lambda { |item| StripeItem.new(item).invalid? },
                                :allow_destroy => true

  def items_count
    {
      "image" => stripe_items.where(item_type: "image").count,
      "embed" => stripe_items.where(item_type: "embed").count,
      "text" => stripe_items.where(item_type: "text").count
    }
  end

  protected

  def set_title
    self.title = "Untitled" unless title.present?
  end
end
