class AddPositionToStripeItem < ActiveRecord::Migration
  def change
    add_column :stripe_items, :position, :integer
  end
end
