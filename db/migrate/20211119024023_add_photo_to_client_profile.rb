class AddPhotoToClientProfile < ActiveRecord::Migration[6.1]
  def change
    def change
      add_column :client_profiles, :photo, :blob
    end
  end
end
