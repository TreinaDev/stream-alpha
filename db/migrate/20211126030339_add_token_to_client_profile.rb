class AddTokenToClientProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :client_profiles, :token, :string
  end
end
