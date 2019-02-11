module SetmoreApi
  class Customer
    REQUEST_PATH = '/bookingapi/customer'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refreash_token
    end
    
    def create customer_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless customer_attributes[:first_name]

      params = {
        :request_path => (REQUEST_PATH + "/create"),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :body_data => customer_attributes
      }

      response = Connection.new.execute(params,'Post')

      fail "Unable to create customer, error: #{response['error']}, msg: #{response['msg']}" unless response && response['response'] && response['data']

      response['data']['customer']
    end

    def get_details customer_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless customer_attributes[:firstname]

      params = {
        :request_path => (REQUEST_PATH),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => customer_attributes
      }

      response = Connection.new.execute(params,'Get')

      fail "Unable to get customer, error: #{response['error']} , msg: #{response['msg']}" unless response && response['response']  && response['data']
      
      response['data']['customer']
    end

  end
end