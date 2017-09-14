module DemoCommonLib
  module WaitHelper
    require_relative 'time_delta'
    extend Appium::Common

    def self.wait_true(timeout = TimeDelta.seconds(5), interval = TimeDelta.seconds(1), msg = '', &block)
      opts = {
          :timeout => timeout.seconds,
          :interval => interval.seconds,
          :message => msg
      }
      super(opts, &block)
    end

    def self.wait(timeout = TimeDelta.seconds(5), interval = TimeDelta.seconds(1), msg = '', &block)
      opts = {
          :timeout => timeout.seconds,
          :interval => interval.seconds,
          :message => msg
      }
      super(opts, &block)
    end

  end
end