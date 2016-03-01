$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "calendar_to_queue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "calendar_to_queue"
  s.version     = CalendarToQueue::VERSION
  s.authors     = ["John Naegle"]
  s.email       = ["john.naegle@goodmeasures.com"]
  s.homepage    = "https://github.com/johnnaegle"
  s.summary     = "Mountable Rails Engine for putting Google Calendar Push Notifications in AWS Queues."
  s.description = "A mountable Rails Engine for receiving HTTPS Push Notifications from watched Google Calendar Resources and adding messages to AWS Queues for consumption by production, staging, development and test environments"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency 'aws-sdk', '~> 2'

  s.add_development_dependency "sqlite3"
end
