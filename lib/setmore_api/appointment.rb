module SetmoreApi
  class Appointment
    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end
  end
end