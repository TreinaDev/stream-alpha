class CreateCustomerPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_payment_methods do |t|
      t.string :pix_token
      t.string :boleto_token
      t.references :client_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
