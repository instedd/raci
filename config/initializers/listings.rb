Listings.configure do |config|
  config.theme = 'materialize'
  config.push_url = true
end

module Listings::Sources
  # force case insensitve search
  class ActiveRecordDataSource
    def search(fields, value)
      criteria = []
      values = []
      fields.each do |field|
        criteria << "#{field.query_column} ilike ?"
        values << "%#{value}%"
      end
      @items = @items.where(criteria.join(' or '), *values)
    end
  end
end
