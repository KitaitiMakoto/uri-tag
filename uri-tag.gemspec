Gem::Specification.new do |spec|
  spec.name          = "uri-tag"
  spec.version       = '0.0.2'
  spec.authors       = ["KITAITI Makoto"]
  spec.email         = ["KitaitiMakoto@gmail.com"]
  spec.summary       = %q{This library extends standard bundled URI library to parse and build tag scheme URI defined in RFC 4151.}
  spec.homepage      = "https://gitorious.org/uri-ext"
  spec.license       = "Ruby"

  spec.test_files    = ['test/uri/test_tag.rb']
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.markdown CHANGELOG.markdown COPYING BSDL]
  spec.files = spec.require_paths.inject([]) {|files, dir|
                 files + Dir.glob("#{dir}/**/*.rb")
               } +
               spec.test_files +
               spec.extra_rdoc_files +
               %w[uri-tag.gemspec Rakefile]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubygems-tasks"
end
