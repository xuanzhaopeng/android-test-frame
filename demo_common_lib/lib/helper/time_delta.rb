module DemoCommonLib
  class TimeDelta
    attr_accessor :seconds

    def initialize(v)
      self.seconds = v
    end

    def self.seconds(v)
      TimeDelta.new(v)
    end

    def self.minute(v)
      TimeDelta.new(v * 60)
    end
  end
end