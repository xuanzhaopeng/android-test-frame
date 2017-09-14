require 'fileutils'
require 'rspec'
require 'rspec/expectations'

require 'demo_common_lib'
DemoCommonLib::Logger.logger

SUPPORT_PATH = File.join(Dir.pwd, 'features/support/')
DEFAULT_APK = File.join(SUPPORT_PATH, 'app-debug.apk')
DEFAULT_APP_PACKAGE = 'im.getsocial.calc'
DEFAULT_APP_ACTIVITY = '.MainActivity'

$demo_debug = true
$global_config = YAML.load_file(File.join(SUPPORT_PATH, 'android.config.yaml'))
$global_config[:driver][:caps]['app'] = ENV['test_app'].nil? ? DEFAULT_APK : ENV['test_app']
$global_config[:driver][:caps]['appPackage'] = ENV['test_app_package'].nil? ? DEFAULT_APP_PACKAGE : ENV['test_app_package']
$global_config[:driver][:caps]['appActivity'] = ENV['test_app_activity'].nil? ? DEFAULT_APP_ACTIVITY : ENV['test_app_activity']

# Start local appium server only if remote_url is not defined in config
if $global_config[:server][:remote_url].nil?
  $remote_server = DemoCommonLib::DemoServer.new $global_config
  $remote_server.restart
end

at_exit do
  if $driver != nil
    $driver.quit
    $driver = nil
  end
end