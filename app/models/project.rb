class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_goals

  validates :name, presence: true

  def for_goal?(id)
    project_goals.any?{|pg| pg.goal == id.to_i}
  end
end
