class Population < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.labels
    all.map{|p| p.name}
  end
end
