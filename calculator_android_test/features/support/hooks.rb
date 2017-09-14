require 'fileutils'
require 'rspec'
require 'rspec/expectations'

require 'demo_common_lib'
require 'cucumber/core'
require_relative '../../lib/pages.rb'

TEST_PASS = true
TEST_FAILED = false

Before do |scenario|
  DemoCommonLib::Logger.info '--------------------------------------------------------------------------------------'
  DemoCommonLib::Logger.info "Scenario : #{scenario.name}"
  DemoCommonLib::Logger.info '--------------------------------------------------------------------------------------'
  $global_driver = DemoCommonLib::DemoDriver.new($global_config)
  $driver = $global_driver.start_driver
end

After do |scenario|
  PageFactory.instance.clear
  if scenario.failed?
    DemoCommonLib::Logger.info '======> Scenario Failed!!!!!'
    take_screenshot('error')
    send_result_to_test_rail(TEST_FAILED, scenario.tags, scenario.exception)
  else
    send_result_to_test_rail(TEST_PASS, scenario.tags)
  end
  clean_driver
end

AfterStep do |result, test_step|
  DemoCommonLib::Logger.info '--------------------------------------------------------------------------------------'
  DemoCommonLib::Logger.info "Step : #{test_step.name}, (status: #{result.class.name.split('::').last || 'Unknown'})"
  DemoCommonLib::Logger.info '--------------------------------------------------------------------------------------'
  take_screenshot(get_valid_name(test_step.name))
end

def clean_driver
  if $driver != nil
    $driver.quit
    $driver = nil
  end
end

def take_screenshot(img_name)
  p "take screenshot #{img_name}"
end

def send_result_to_test_rail(is_pass, tags, exception = '')
  p "TestRail: #{is_pass}, #{tags}, #{exception}"
end

def get_valid_name(value)
  value.strip.gsub(/[^A-Za-z0-9]/, '_')
end