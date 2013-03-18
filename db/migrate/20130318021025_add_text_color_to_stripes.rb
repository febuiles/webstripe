class AddTextColorToStripes < ActiveRecord::Migration
  def change
    add_column :stripes, :text_color, :string, :default => "e9e5ca"
  end
end
