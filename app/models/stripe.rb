class Stripe < ActiveRecord::Base
  has_many :stripe_items, :dependent => :destroy
  belongs_to :user

  attr_accessible :title, :user_id, :stripe_items_attributes

  accepts_nested_attributes_for :stripe_items
end
