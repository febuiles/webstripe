class AddAlignmentToStripe < ActiveRecord::Migration
  def change
    add_column :stripes, :alignment, :text
  end
end
