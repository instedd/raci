class Organization < ApplicationRecord
  belongs_to :user
  has_many :projects
  validates :name, uniqueness: true, presence: true

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: [false, nil]) }
end
