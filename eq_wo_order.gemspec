Gem::Specification.new do |s|
  s.name        = 'eq_wo_order'
  s.version     = '0.0.1'
  s.date        = '2016-02-29'
  s.summary     = 'RSpec equality matcher that ignores nested order'
  s.description = 'RSpec equality matcher that recursively sorts lists, hashes, and lists of hashes before comparing'
  s.authors     = ['Jean de Klerk']
  s.email       = 'jadekler@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/eq_wo_order'
  s.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  s.add_runtime_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
