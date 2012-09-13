class CreateStripes < ActiveRecord::Migration
  def change
    create_table :stripes do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
