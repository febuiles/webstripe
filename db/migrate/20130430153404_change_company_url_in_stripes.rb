class ChangeCompanyUrlInStripes < ActiveRecord::Migration
  def change
    change_column :stripes, :company_url, :string, default: ""
    change_column :stripes, :company, :string, default: ""
  end
end
