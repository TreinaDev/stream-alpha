class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :email_valid
  validates :email, :password, presence: true
  has_many :game_categories, dependent: :nullify

  private

  def email_valid
    regex = /^[A-Za-z0-9+_.-]+@gamestream.com.br/
    message = "deve pertencer ao domínio @gamestream.com.br, os únicos caracteres especiais permitidos são '_ . -'"
    errors.add(:email, message) unless email =~ regex
  end
end
