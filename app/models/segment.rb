class Segment < ApplicationRecord
  has_many :stats

  validates  :name,
  presence: true
end
