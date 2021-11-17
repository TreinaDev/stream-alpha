class AddCpfAndCepToClientProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :client_profiles, :cep, :string
    add_column :client_profiles, :cpf, :string
  end
end
