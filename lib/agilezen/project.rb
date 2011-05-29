module AgileZen
  class Project < Base
    # Standard attributes
    attr_accessor :id, :name, :description, :createTime, :owner

    class << self
  
      # All of the projects (depends on pagesize).
      def all(options={})
        response = self.connection.get do |req|
          req.url "/api/v1/projects", options
        end
    
        parse_projects(response.body.items)
      end
  
    end
  
    private
  
    def parse_projects(result)
      parse(result, AgileZen::Project)
    end
  
    def parse(records, klass=self)
      records.map do |record| 
        klass.new(record)
      end
    end
  end
end