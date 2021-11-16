class CreateClientProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :client_profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.integer :cpf
      t.integer :cep
      t.string :city
      t.string :state
      t.string :residential_address
      t.integer :residential_number
      t.string :age_rating
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
