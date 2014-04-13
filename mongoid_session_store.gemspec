Gem::Specification.new do |s|
  s.name = "mongoid_session_store"
  s.version = "4.0.0"
  s.authors     = ["Ryan Fitzgerald, Dimitri Kurashvili", "Code Brew Studios, C12.ge"]
  s.email       = ["ryan@codebrewstudios.com, dimitri@c12.ge"]
  s.homepage    = "http://github.com/dimakura/mongoid_session_store"
  s.summary = "Store rails 4 sessions in mongoDB (with mongoid4 gem)."
  s.description = "Store rails 4 sessions in mongoDB (with mongoid4 gem)."
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  
  s.add_dependency('rails', '>= 4.0.0')
  s.add_dependency('mongoid', '~> 4.0.0.beta1')
end
