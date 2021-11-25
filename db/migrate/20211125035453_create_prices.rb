class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.boolean :loose
      t.decimal :value

      t.timestamps
    end
  end
end
