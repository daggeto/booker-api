RSpec::Matchers.define :has_role? do |expected|
  match { |actual| actual.has_role? expected }
end
