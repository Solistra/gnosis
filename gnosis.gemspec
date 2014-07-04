lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gnosis/version'

Gem::Specification.new do |gem|
  gem.name     = 'gnosis'
  gem.version  = Gnosis::VERSION
  gem.authors  = ['Solistra']
  gem.email    = ['solistra@gmx.com']
  gem.homepage = 'https://github.com/Solistra/gnosis'
  gem.platform = Gem::Platform::RUBY
  gem.license  = 'LGPL-3.0'
  
  gem.summary     = 'Gnosis performs in-memory decryption of RGSS archives.'
  gem.description = %{
    Gnosis allows developers to perform in-memory decryption of the contents
    of RGSSAD and RGSS3A archives (as used by the RPG Maker series) to binary
    strings.
  }.gsub(/\s+/, " ").strip
  
  %w(bundler rake rspec yard).each do |dep|
    gem.add_development_dependency(dep)
  end
  
  gem.files        = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  gem.require_path = 'lib'
end
