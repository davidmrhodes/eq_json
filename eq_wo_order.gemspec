Gem::Specification.new do |s|
  s.name        = 'eq_wo_order'
  s.version     = '0.3.0'
  s.date        = '2016-02-29'
  s.summary     = 'RSpec equality matcher that ignores nested order'
  s.description = 'RSpec equality matcher that deeply compares array without order - arrays of primitives, hashes, and arrays. Examples at github.com/jadekler/eq_wo_order'
  s.authors     = ['Jean de Klerk']
  s.email       = 'jadekler@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/eq_wo_order'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
end
