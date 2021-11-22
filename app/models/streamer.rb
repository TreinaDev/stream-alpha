class Streamer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :streamer_profile, dependent: :destroy
  has_many :videos, dependent: :nullify
  has_many :content_streamers, dependent: :destroy
  has_many :plan, through: :content_streamers

  enum profile_status: { pending: 5, completed: 10 }
end
