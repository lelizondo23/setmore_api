module SetmoreApi
  class Token
    
    REQUEST_PATH = '/o/oauth2/token'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refreash_token
    end
    
    def set_refreash_access_token
      params = {
        :request_path => REQUEST_PATH,
        :query_params => {
          :refreshToken =>  SetmoreApi.configuration.refreash_token
        } 
      }

      response = Connection.new.execute(params,'Get')

      fail 'Unable to get access token' unless response || response['response']

      SetmoreApi.configuration.access_token = response['data']['token']['access_token'] 
      SetmoreApi.configuration.token_expire_time = response['data']['token']['expires'] 

      response['data']['token']
    end

    def self.is_expired?
      fail 'Token not set' unless SetmoreApi.configuration.token_expire_time
      
      DateTime.now.strftime('%Q').to_i > SetmoreApi.configuration.token_expire_time
    end

  end
end