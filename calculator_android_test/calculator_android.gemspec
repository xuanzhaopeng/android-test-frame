require 'time'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.2.6'

  s.name          = 'calculator_android'
  s.version       = '0.0.1'
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.description   = s.summary = 'Calculator demo test framework'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['xuanzhaopeng@gmail.com']
  s.homepage      = 'http://github.com/xuanzhaopeng'
  s.require_paths = ['lib', 'features/support', 'features/step_definitions']

  s.add_dependency 'watir', '= 6.5.0'
  s.add_dependency 'page-object', '= 2.0.0'
  s.add_dependency 'demo_common_lib', '~> 0.0.1'

  s.files = `git ls-files`.split "\n"
end