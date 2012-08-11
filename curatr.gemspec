require File.expand_path("../lib/curatr/version", __FILE__)

Gem::Specification.new do |s|
  
  s.name        = 'curatr'
  s.version     = Curatr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2012-08-02'
  s.summary     = "curatr-#{s.version}"
  s.description = "On-the-go curation tool."
  s.authors     = ["Andrew Sprinz"]
  s.email       = 'andrew@goodfornothing.com'
  s.homepage    = 'https://github.com/goodfornothing/curatr'

  s.rubyforge_project         = "curatr"
  s.required_rubygems_version = "> 1.3.6"

  s.add_dependency "activesupport" , ">= 3.0.7"
  s.add_dependency "rails"         , ">= 3.0.7"  
  s.add_dependency "bitly"
  s.add_dependency "profanalyzer"
  s.add_dependency "daemons"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

end