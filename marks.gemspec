$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'marks/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'marks'
  s.version     = Marks::VERSION
  s.authors     = ['Masahiro Ihara']
  s.email       = ['ihara2525@gmail.com']
  s.homepage    = 'https://github.com/ihara2525/marks'
  s.summary     = 'An engine that enable you to mark any ActiveRecord model as many as you like'
  s.description = 'An engine that enable you to mark any ActiveRecord model as many as you like'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 3.2.9'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'pry'
end
