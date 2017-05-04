class ProjectGoal < ApplicationRecord
  belongs_to :project

  def to_s
    SustainableDevelopmentGoal.find(goal).name
  end

  def sustainable_development_goal
    SustainableDevelopmentGoal.find(goal)
  end
end
