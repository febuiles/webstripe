class ChangeUserRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "basic"
  end
end
