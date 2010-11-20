Gem::Specification.new do |gem|
  gem.name    = 'sinistr'
  gem.version = '0.1.0'
  gem.date    = Date.today.to_s
  
  gem.summary = "Gem for creating/removing sinatra folder structure."
  gem.description = "Gem for creating/removing sinatra folder structure using command line."
  
  gem.authors  = ['Miquel Oliete']
  gem.email    = 'miquel@miqueloliete.com'
  gem.homepage = 'http://github.com/mob1970/sinistr'
  
  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*',
                  'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end

