# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','yelp_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'ugalic_yelp'
  s.version = Yelp::VERSION
  s.author = 'Uros Galic'
  s.email = 'uros.galic@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Get popular pub in a given city'
# Add your other files here if you make them
  s.files = %w(
bin/yelp
lib/yelp_version.rb
lib/yelp/api.rb
lib/yelp/web.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','yelp.rdoc']
  s.rdoc_options << '--title' << 'yelp' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'yelp'
  
  s.rubyforge_project = "ugalic_yelp"
  
  s.add_runtime_dependency('gli')
  s.add_development_dependency('mechanize')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('oauth')
  s.add_development_dependency('rspec')
  s.add_development_dependency('aruba', '~> 0.4.6')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
end
