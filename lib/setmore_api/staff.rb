module SetmoreApi
  class Stafff
    
    REQUEST_PATH = '/bookingapi/services'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end

  end
end