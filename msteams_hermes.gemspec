# frozen_string_literal: true

require_relative "lib/msteams_hermes/version"

Gem::Specification.new do |spec|
  spec.name          = "msteams_hermes"
  spec.version       = MsTeamsHermes::VERSION
  spec.authors       = ["Rafael Rocha"]
  spec.email         = "opensource@xing.com"
  spec.date          = Time.now.strftime("%Y-%m-%d")

  spec.summary       = "Send messages to any Microsoft Teams' channel as easy as possible."
  spec.description   = "This gem helps you sending messages to your Microsoft Teams channels. " \
                       "With autonomy to create your own layouts, like UI kits such as React, Flutter, SwiftUI " \
                       "(and some others), you will be able to customize it with the objects representations of " \
                       "Microsoft's adaptive cards."
  spec.homepage      = "https://github.com/xing/msteams_hermes"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/xing/msteams_hermes"
  spec.metadata["changelog_uri"] = "https://github.com/xing/msteams_hermes/CHANGELOG.md"

  spec.required_ruby_version = Gem::Requirement.new(">= 3.1")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "webmock", "~> 3.23"
end
