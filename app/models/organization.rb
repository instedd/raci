class Organization < ApplicationRecord
  belongs_to :user
  has_many :projects
  validates :name, uniqueness: true, presence: true
end
