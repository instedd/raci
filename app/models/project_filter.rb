class ProjectFilter
  include ActiveModel::Model
  attr_accessor :location
  attr_accessor :population
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :name
  attr_accessor :legally_formed
  attr_accessor :sustainable_development_goal
  attr_accessor :page
end
