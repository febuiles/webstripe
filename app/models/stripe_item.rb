class StripeItem < ActiveRecord::Base
  attr_accessible :content, :item_type, :stripe_id
end
