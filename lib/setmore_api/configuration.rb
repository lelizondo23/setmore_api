module SetmoreApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration

    attr_accessor :refreash_token
    attr_accessor :access_token    
    attr_accessor :token_expire_time
  end
end