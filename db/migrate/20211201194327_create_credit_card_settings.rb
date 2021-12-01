class CreateCreditCardSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_card_settings do |t|
      t.string :nickname
      t.string :encrypted_digits
      t.string :token
      t.references :customer_payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
