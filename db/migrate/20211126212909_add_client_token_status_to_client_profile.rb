class AddClientTokenStatusToClientProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :client_profiles, :client_token_status, :integer, default: 5
  end
end
