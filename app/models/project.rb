class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_goals, dependent: :destroy

  validates :name, presence: true

  scope :published, -> { where(published: true) }

  def for_goal?(id)
    project_goals.any?{|pg| pg.goal == id.to_i}
  end

  def self.apply(filters)
    search = published.includes(:organization).includes(:project_goals)
    search = search.where("location ILIKE (?)", "%#{filters.location}%") if filters.location.present?
    search = search.where(population: filters.population) if filters.population.present?
    search = search.where("start_date >= ? AND start_date <= ?","#{filters.start_date}-01-01","#{filters.start_date}-12-31") if filters.start_date.present?
    search = search.where("end_date >= ? AND end_date <= ?","#{filters.end_date}-01-01","#{filters.end_date}-12-31") if filters.end_date.present?
    search = search.references(:project_goals).where("project_goals.goal = ?",filters.sustainable_development_goal.to_i) if filters.sustainable_development_goal.present?
    search = search.where("organizations.legally_formed = ?", filters.legally_formed) if filters.legally_formed.present?
    search = search.where("projects.name ILIKE (?)", "%#{filters.name}%") if filters.name.present?
    ids = search.select("projects.id","organization_id").map{|r| r.id}
    where("projects.id IN (?)", ids)
  end

  def self.categorization_by_sdg(projects)
    res = Hash.new({total: 0, by_location: {}, by_population: {}})
    projects.each do |p|
    end
  end
end
