require "spec_helper"

describe AgileZen::Project do
  
  describe "all" do
    use_vcr_cassette
    
    it "performs an API request for all projects" do
      projects = AgileZen::Project.all
      projects.count.should eql(1)
      projects.first.name.should eql("Teh Diff")
    end
  end
  
end