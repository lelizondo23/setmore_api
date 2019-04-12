module SetmoreApi
  class Service

    REQUEST_PATH = '/bookingapi/services'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refresh_token
    end

    def fetch_all
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?

      params = {
        :request_path => REQUEST_PATH,
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        }
      }

      response = Connection.new.execute(params,'Get')

      fail "Unable to get access services, error: #{response['error']}, msg: #{response['msg']}" unless response && response['response'] && response['data']

      response['data']['services']
    end

  end
end