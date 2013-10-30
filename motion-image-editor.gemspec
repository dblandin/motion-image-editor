# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name          = 'motion-image-editor'
  spec.version       = '0.0.3'
  spec.authors       = ['Devon Blandin']
  spec.email         = ['dblandin@gmail.com']
  spec.description   = %q{RubyMotion image editing controller}
  spec.summary       = %q{Easily scale, rotate, and crop images}
  spec.homepage      = "http://github.com/dblandin/motion-image-editor"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'motion-cocoapods'
  spec.add_development_dependency 'rake'
end
