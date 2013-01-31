module Teacup

  class << self
    def configuration
      @configuration ||= Config.new
    end

    def config
      yield(configuration)
    end
  end

  class Config
    attr_accessor :instant_style

    def initialize
      @instant_style = false
    end

  end
end