require_relative 'lib/common/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.2.6'

  s.name          = 'demo_common_lib'
  s.version       = DemoCommonLib::VERSION
  s.date          = DemoCommonLib::DATE
  s.description   = s.summary = 'Ruby library for Demo automation framework'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['xuanzhaopeng@gmail.com']
  s.homepage      = 'http://github.com/xuanzhaopeng'
  s.require_paths = %w[lib]

  s.add_runtime_dependency 'appium_lib', '= 9.6.1'
  s.add_runtime_dependency 'cucumber', '= 2.4.0'
  s.add_runtime_dependency 'rspec', '= 3.5.0'
  s.add_runtime_dependency 'rspec-expectations', '= 3.5.0'

  s.files = `git ls-files`.split "\n"
end