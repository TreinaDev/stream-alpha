class Price < ApplicationRecord
  belongs_to :video
  validates :value, numericality: { less_than_or_equal_to: 99.0 }
end
