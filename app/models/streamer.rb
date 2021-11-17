class Streamer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :streamer_profile, dependent: :destroy

  enum profile_status: { pending: 5, completed: 10 }

end
