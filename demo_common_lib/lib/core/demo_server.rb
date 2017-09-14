module DemoCommonLib
  class DemoServer
    require 'fileutils'

    OPTIONS = {
        :server => {
            :type => :appium,
            :appium_path => '/usr/local/bin/appium',
            :appium_log_path => '/usr/local/var/log',
            :node_path => '/usr/local/bin/node',
            :host => '127.0.0.1',
            :port => 4723,
            :selendroid_port => 4444,
            :start_timeout => 60,
        },
        :driver => {
            :caps => {
                browser_name: 'any'
            }
        }
    }

    def initialize(opt = {})
      OPTIONS.merge!(opt)
      self
    end

    private

    def command
      ensure_appium_server
      @appium_commands = [
          OPTIONS[:server][:node_path], OPTIONS[:server][:appium_path],
          '--port', OPTIONS[:server][:port],
          '--session-override',
          '--selendroid-port', OPTIONS[:server][:selendroid_port],
          '--log', "#{OPTIONS[:server][:appium_log_path]}/appium.log",
          '--log-timestamp',
          '> /dev/null 2>&1',
          '&'
      ]
    end

    def ensure_appium_server
      OPTIONS[:server][:node_path] = 'node' unless File.exist? OPTIONS[:server][:node_path]
      OPTIONS[:server][:appium_path] = 'appium' unless File.exist? OPTIONS[:server][:appium_path]

      dirname = File.dirname(OPTIONS[:server][:appium_log_path])
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
        DemoCommonLib::Logger.info("=> [Create] Create appium log folder #{OPTIONS[:server][:appium_log_path]}")
      end
      FileUtils.touch("#{OPTIONS[:server][:appium_log_path]}/appium.log")
    end

    def wait_until_server_start
      response = nil
      timeout = TimeDelta.seconds(OPTIONS[:server][:start_timeout])
      interval = TimeDelta.seconds(1)
      err_msg = "Server is not started after #{OPTIONS[:server][:start_timeout]} seconds"
      DemoCommonLib::WaitHelper.wait_true(timeout, interval, err_msg) {
        begin
          Net::HTTP.start(OPTIONS[:server][:host], OPTIONS[:server][:port]) { |http|
            response = http.get('/wd/hub/sessions')
          }
          DemoCommonLib::Logger.info("=> Remote server return HTTP code => #{response.code}")
          response.code == '200'
        rescue Exception => e
          DemoCommonLib::Logger.info("=> Connection refused by Remote server ... [GET] #{OPTIONS[:server][:host]}:#{OPTIONS[:server][:port]}/wd/hub/sessions : #{e.to_s}")
          false
        end
      }
      DemoCommonLib::Logger.info('=> Remote server started!')
    end

    public

    def running?
      begin
        response = nil
        Net::HTTP.start(OPTIONS[:server][:host], OPTIONS[:server][:port]) { |http|
          response = http.get('/wd/hub/sessions')
        }
        response == 200
      rescue Errno::ECONNREFUSED
        false
      end
    end

    def restart
      DemoCommonLib::Logger.info("\nRestart remote server[#{OPTIONS[:server][:type]}]:")
      DemoCommonLib::Logger.info("=> GLOBAL CONFIG > #{OPTIONS.inspect}")

      unless running?
        Mutex.new.synchronize do
          system('killall node')
          start_cmd = command.join(' ')
          spawn(start_cmd)
          DemoCommonLib::Logger.info("Start #{OPTIONS[:server][:type]} server ...[#{start_cmd}]")
          wait_until_server_start
        end
      else
        DemoCommonLib::Logger.info("#{OPTIONS[:server][:type]} Server already start")
      end
    end
  end
end