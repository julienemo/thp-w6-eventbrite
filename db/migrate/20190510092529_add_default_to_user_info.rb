class AddDefaultToUserInfo < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :last_name, :string, :default => "UNKNOWN"
    change_column :users, :first_name, :string, :default => "Unknown"
    change_column :users, :description, :text, :default => "You said nothing about yourself..."

  end
end
