module SetmoreApi
  class Stafff
    
    REQUEST_PATH = '/bookingapi/staffs'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end

    def get_staff
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      params = {
        :request_path => REQUEST_PATH,         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        }
      }
      response = Connection.new.get(params)
      fail "Unable to get access staff, error: #{response['error']}" unless response && response['response'] 
      response['data']['staffs']
    end

  end
end