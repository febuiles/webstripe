class CreateStripeItems < ActiveRecord::Migration
  def change
    create_table :stripe_items do |t|
      t.string :item_type
      t.integer :stripe_id
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
