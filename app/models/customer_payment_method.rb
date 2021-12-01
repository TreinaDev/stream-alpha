class CustomerPaymentMethod < ApplicationRecord
  belongs_to :client_profile
  has_many :credit_card_settings
end
