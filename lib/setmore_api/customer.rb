module SetmoreApi
  class Customer
    REQUEST_PATH = '/bookingapi/customer'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end
    
    def create_customer customer_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless customer_attributes[:first_name]
      params = {
        :request_path => (REQUEST_PATH+"/create"),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :body_data => slots_attributes
      }
      response = Connection.new.post(params)
      fail "Unable to create customer, error: #{response['error']}" unless response && response['response'] 
      response['data']['customer']
    end

    def get_customer customer_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless customer_attributes[:first_name]
      params = {
        :request_path => (REQUEST_PATH),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => customer_attributes
      }
      response = Connection.new.get(params)
      fail "Unable to get customer, error: #{response['error']}" unless response && response['response'] 
      response['data']['customer']
    end

  end
end