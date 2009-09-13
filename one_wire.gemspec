# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{one_wire}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Hollingworth"]
  s.date = %q{2009-09-13}
  s.email = %q{mdholling@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/one_wire.rb",
    "lib/one_wire/config.rb",
    "lib/one_wire/constants.rb",
    "lib/one_wire/device.rb",
    "lib/one_wire/directory.rb",
    "lib/one_wire/exceptions.rb",
    "lib/one_wire/request.rb",
    "lib/one_wire/response.rb",
    "lib/one_wire/retry.rb",
    "lib/one_wire/transaction.rb",
    "spec/one_wire_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mholling/one_wire}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby library for talking to a one-wire server (see http://owfs.org)}
  s.test_files = [
    "spec/one_wire_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
