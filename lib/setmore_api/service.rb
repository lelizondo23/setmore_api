module SetmoreApi
  class Service
    
    REQUEST_PATH = '/bookingapi/services'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end

    def get_services
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      params = {
        :request_path => REQUEST_PATH,         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        }
      }
      response = Connection.new.get(params)
      fail "Unable to get access services, error: #{response['error']}" unless response && response['response'] 
      response['data']['services']
    end

  end
end