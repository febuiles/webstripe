class AddStateToStripes < ActiveRecord::Migration
  def change
    add_column :stripes, :state, :string
  end
end
