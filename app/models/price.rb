class Price < ApplicationRecord
  belongs_to :video

  validates :value, numericality: true
end
