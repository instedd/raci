class Organization < ApplicationRecord
  belongs_to :user
  has_many :projects

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: [false, nil]) }
end
