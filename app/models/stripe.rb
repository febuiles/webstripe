class Stripe < ActiveRecord::Base
  has_many :stripe_items, :dependent => :destroy
  belongs_to :user

  attr_accessible :title, :user_id, :stripe_items_attributes, :alignment

  before_save :set_title
  validate :number_of_stripe_items

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

  def number_of_stripe_items
    if stripe_items.size < 1
      errors.add(:base, "The stripe must contain at least one item.")
    end
  end
end
