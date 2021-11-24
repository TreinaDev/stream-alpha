class CreateContentStreamers < ActiveRecord::Migration[6.1]
  def change
    create_table :content_streamers do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :streamer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
