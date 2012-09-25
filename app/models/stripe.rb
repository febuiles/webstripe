class Stripe < ActiveRecord::Base
  has_many :stripe_items, :dependent => :destroy
  belongs_to :user

  attr_accessible :title, :user_id, :stripe_items_attributes

  validates_presence_of :title, :user_id
  validate :number_of_stripe_items

  accepts_nested_attributes_for :stripe_items, :reject_if => lambda { |item| StripeItem.new(item).invalid? }

  protected

  def number_of_stripe_items
    if stripe_items.size < 1
      errors.add(:base, "The stripe must contain at least one item.")
    end
  end
end
