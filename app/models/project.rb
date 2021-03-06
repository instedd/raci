class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_goals, dependent: :destroy
  has_and_belongs_to_many :locations, dependent: :destroy
  has_and_belongs_to_many :populations, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :published, -> { where(published: true) }
  scope :pending, -> { where(published: [false, nil]) }

  def for_goal?(id)
    project_goals.any?{|pg| pg.goal == id.to_i}
  end

  def self.apply(filters, page_size)
    search = published.eager_load(:organization).includes(:project_goals).includes(:locations).includes(:populations)
    search = search.where("organizations.accepted = ?", true)
    search = search.where("locations.name ILIKE (?)", "%#{filters.location}%") if filters.location.present?
    search = search.where("populations.name ILIKE (?)", "%#{filters.population}%") if filters.population.present?
    search = search.where("start_date >= ? AND start_date <= ?","#{filters.start_date}-01-01","#{filters.start_date}-12-31") if filters.start_date.present?
    search = search.where("end_date >= ? AND end_date <= ?","#{filters.end_date}-01-01","#{filters.end_date}-12-31") if filters.end_date.present?
    search = search.references(:project_goals).where("project_goals.goal = ?",filters.sustainable_development_goal.to_i) if filters.sustainable_development_goal.present?
    search = search.where("organizations.legally_formed = ?", filters.legally_formed) if filters.legally_formed.present?
    search = search.where("projects.name ILIKE (?)", "%#{filters.name}%") if filters.name.present?
    ids = search.select("projects.id","organization_id").map{|r| r.id}
    offset = (filters.page - 1) * page_size if filters.page.present?
    {results: where("projects.id IN (?)", ids).eager_load(:organization).includes(:project_goals).includes(:locations).includes(:populations).limit(page_size).offset(offset),
      total: where("projects.id IN (?)", ids).count()}
  end

  def self.categorization_by_sdg(projects)
    res = {sdg_counts: Hash.new(0), by_location: {}, by_population: {}}
    projects.each do |p|
      p.project_goals.each do |pg|
        res[:sdg_counts][pg.goal] += 1
        p.populations.each do |pop|
          res[:by_population][pop.name] = Hash.new(0) unless res[:by_population].has_key?(pop.name)
          res[:by_population][pop.name][pg.goal] += 1
        end
        p.locations.each do |loc|
          res[:by_location][loc.code] = Hash.new(0) unless res[:by_location].has_key?(loc.code)
          res[:by_location][loc.code][pg.goal] += 1
        end
      end
    end
    res
  end

  def self.categorization_by_location(projects)
    res = {location_counts: Hash.new(0), by_sdg: {}, by_population: {}}
    projects.each do |p|
      p.locations.each do |loc|
        res[:location_counts][loc.code] += 1
        p.populations.each do |pop|
          res[:by_population][pop.name] = Hash.new(0) unless res[:by_population].has_key?(pop.name)
          res[:by_population][pop.name][loc.code] += 1
        end
        p.project_goals.each do |pg|
          res[:by_sdg][pg.goal] = Hash.new(0) unless res[:by_sdg].has_key?(pg.goal)
          res[:by_sdg][pg.goal][loc.code] += 1
        end
      end
    end
    res
  end

  def self.categorization_by_population(projects)
    res = {population_counts: Hash.new(0), by_sdg: {}, by_location: {}}
    projects.each do |p|
      p.populations.each do |pop|
        res[:population_counts][pop.name] += 1
        p.project_goals.each do |pg|
          res[:by_sdg][pg.goal] = Hash.new(0) unless res[:by_sdg].has_key?(pg.goal)
          res[:by_sdg][pg.goal][pop.name] += 1
        end
        p.locations.each do |loc|
          res[:by_location][loc.code] = Hash.new(0) unless res[:by_location].has_key?(loc.code)
          res[:by_location][loc.code][pop.name] += 1
        end
      end
    end
    res
  end

  def self.categorization_by_upload_time(projects)
    res = {timeline_counts: Hash.new(0), by_sdg: {}, by_location: {}, by_population: {}}
    projects.each do |p|
      date = p.week_of_upload
      res[:timeline_counts][date] += 1
      p.populations.each do |pop|
        res[:by_population][pop.name] = Hash.new(0) unless res[:by_population].has_key?(pop.name)
        res[:by_population][pop.name][date] += 1
      end
      p.project_goals.each do |pg|
        res[:by_sdg][pg.goal] = Hash.new(0) unless res[:by_sdg].has_key?(pg.goal)
        res[:by_sdg][pg.goal][date] += 1
      end
      p.locations.each do |loc|
        res[:by_location][loc.code] = Hash.new(0) unless res[:by_location].has_key?(loc.code)
        res[:by_location][loc.code][date] += 1
      end
    end
    res[:timeline_counts] = res[:timeline_counts].to_a
    res[:by_sdg].each_pair{ |k,v| res[:by_sdg][k] = v.to_a }
    res[:by_location].each_pair{ |k,v| res[:by_location][k] = v.to_a }
    res[:by_population].each_pair{ |k,v| res[:by_population][k] = v.to_a }
    res
  end

  def week_of_upload()
    date = created_at.beginning_of_week
    "#{date.year}-#{date.month}-#{date.day}"
  end

end
