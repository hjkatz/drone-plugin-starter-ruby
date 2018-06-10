$LOAD_PATH.unshift File.expand_path("lib", __dir__)

Gem::Specification.new do |spec|
  spec.name                  = "drone_plugin"
  spec.version               = "0.0.1"
  spec.required_ruby_version = "~> 2.5.1"
  spec.authors               = ["Harrison Katz"]
  spec.email                 = ["hjkatz03@gmail.com"]

  spec.summary     = %q{Starter project for creating a Drone Plugin with Ruby}
  spec.description = %q{Starter project for creating a Drone Plugin with Ruby}

  spec.files  = ["README.md"]
  spec.files += Dir.glob("lib/**/*")
  spec.files += Dir.glob("exe/drone_plugin")

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "awesome_print"

  spec.add_runtime_dependency "env_bang"
  spec.add_runtime_dependency "liquid"
end
