class CustomerPaymentMethod < ApplicationRecord
  belongs_to :client_profile
end
