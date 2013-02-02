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
    attr_accessor :restyle_on_rotation

    def initialize
      @instant_style = false
      @restyle_on_rotation = true
    end

  end
end