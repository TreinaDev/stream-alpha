class AddVideoRefToPrice < ActiveRecord::Migration[6.1]
  def change
    add_reference :prices, :video, null: false, foreign_key: true
  end
end
