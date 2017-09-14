module DemoCommonLib
  module Logger
    class << self
      extend Forwardable
      def_delegators :logger, :ap, :fatal, :error, :warn, :info, :debug, :level, :level=, :formatter, :formatter=

      [:fatal, :error, :warn, :info, :debug].each do |level|
        define_method("ap_#{level}") { |obj| logger.ap(obj, level) }
      end

      attr_writer :logger

      def logger
        @logger ||= begin
          logger = ::Logger.new($stdout)
          logger.level = ::Logger::INFO
          logger.formatter = proc { |_severity, _datetime, _progname, msg| "#{msg}\n" }
          logger
        end
      end
    end
  end
end
