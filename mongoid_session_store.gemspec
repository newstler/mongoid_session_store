Gem::Specification.new do |s|
  s.name = "mongoid3_session_store"
  s.version = "3.0.0"
  s.authors     = ["Ryan Fitzgerald, Dimitri Kurashvili", "Code Brew Studios, C12.ge"]
  s.email       = ["ryan@codebrewstudios.com, dimitri@c12.ge"]
  s.homepage    = "http://github.com/dimakura/mongoid_session_store"
  s.summary = "Store rails 3 sessions in mongoDB (with mongoid3 gem)."
  s.description = "Store rails 3 sessions in mongoDB (with mongoid3 gem)."
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  
  s.add_dependency('rails', '~> 3.0')
  s.add_dependency('mongoid', '~> 3.0')
end
