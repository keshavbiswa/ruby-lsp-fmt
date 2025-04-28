# frozen_string_literal: true

require_relative "lib/ruby_lsp/rubyfmt_lsp/version"

Gem::Specification.new do |spec|
  spec.name = "rubyfmt_lsp"
  spec.version = RubyLsp::RubyfmtLsp::VERSION
  spec.authors = ["Keshav Biswa"]
  spec.email = ["keshavbiswa21@gmail.com"]

  spec.summary = "Ruby Lsp Addon for rubyfmt"
  spec.description = "Ruby Lsp Addon for rubyfmt"
  spec.homepage = "https://github.com/keshavbiswa/ruby-lsp-fmt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/keshavbiswa/ruby-lsp-fmt"
  spec.metadata["changelog_uri"] = "https://github.com/keshavbiswa/ruby-lsp-fmt/releases"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency("ruby-lsp", "~> 0.23.0")
end
