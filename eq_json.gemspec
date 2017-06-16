Gem::Specification.new do |s|
  s.name        = 'eq_json'
  s.version     = '2.0.1'
  s.date        = '2017-05-12'
  s.summary     = 'RSpec equality matcher that compares JSON'
  s.description = 'RSpec equality matcher that deeply compares JSON. Examples at github.com/davidmrhodes/eq_json'
   s.authors     = ['David M. Rhodes']
  s.email       = 'barnaby71@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/eq_json'
  s.license     = 'MIT'

  s.files       = `git ls-files -z`.split("\x0").find_all{|file| file !~ /doc\//}
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rspec', '~> 3.0'
  s.add_runtime_dependency 'json', '~> 1.7'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
end
