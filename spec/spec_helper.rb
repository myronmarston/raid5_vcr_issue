require "rspec"
require "support/vcr_setup"
require "agilezen"

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end