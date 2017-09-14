module DemoCommonLib
  class DemoDriver < Appium::Driver
    def initialize(config = {}, remote_server_url)
      super(config_to_caps(config), true)
      @custom_url = (remote_server_url.nil? || remote_server_url.empty?) ? 'http://127.0.0.1:4723/wd/hub' : remote_server_url
    end

    def config_to_caps(config)
      {
          'caps': config[:driver][:caps]
      }
    end
  end
end