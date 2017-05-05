class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_goals, dependent: :destroy

  validates :name, presence: true

  scope :published, -> { where(published: true) }

  def for_goal?(id)
    project_goals.any?{|pg| pg.goal == id.to_i}
  end
end
