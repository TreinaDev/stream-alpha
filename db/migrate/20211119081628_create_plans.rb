class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.decimal :value

      t.timestamps
    end
  end
end
