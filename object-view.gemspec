Gem::Specification.new do |s|
  s.authors   = ['Mike Moore']
  s.email       = 'm.moore.denver@gmail.com'
  s.name        = 'object-view'
  s.description = 'Object oriented approach to generating HTML content'
  s.version     = '0.4.9'
  s.homepage  = 'https://github.com/mikejmoore/object-view'
  s.license   = 'MIT'
  s.summary     = "Object oriented views"
  s.files = Dir.glob("{bin,lib}/**/*")
  s.files <<    "lib/object-view.rb"
  s.require_paths = ["lib", "lib/object-view"]
  s.license       = 'MIT'
  
  s.add_development_dependency 'byebug', '~> 6.0'
  s.add_development_dependency 'nokogiri', '~> 1.6.8'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-its', '1.2'
  
end 

