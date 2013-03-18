class AddPremiumFieldsToStripe < ActiveRecord::Migration
  def change
    add_column :stripes, :company, :string
    add_column :stripes, :company_url, :string
    add_column :stripes, :page_bg_color, :string, :default => "e9e5ca"
    add_column :stripes, :stripe_bg_color, :string, :default => "050011"
    add_column :stripes, :fg_color, :string, :default => "db0909"
    add_column :stripes, :premium, :boolean, :default => false
    add_column :stripes, :company_logo, :string
  end
end
