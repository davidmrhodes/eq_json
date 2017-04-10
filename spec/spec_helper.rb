RSpec.configure do |c|
  c.order = :random
  c.default_formatter = 'doc'
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end
