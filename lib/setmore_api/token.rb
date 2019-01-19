module SetmoreApi
  class Token
    
    REQUEST_PATH = '/o/oauth2/token'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end

    def get_access_token
      params = {:request_path => REQUEST_PATH, :refreshToken =>  SetmoreApi.configuration.refreash_token}
      access_token = Connection.new.get(params)
    end

  end
end