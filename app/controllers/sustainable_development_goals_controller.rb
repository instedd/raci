class SustainableDevelopmentGoalsController < ApplicationController
  layout 'sdg'

  def detail
    @goal = SustainableDevelopmentGoal.all.find{|g| g.url == params["goal"]}
    render "#{@goal.number}"
  end
end
