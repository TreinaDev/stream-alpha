class RemoveCpfAndCep < ActiveRecord::Migration[6.1]
  def change
    remove_column :client_profiles, :cpf
    remove_column :client_profiles, :cep
  end
end
