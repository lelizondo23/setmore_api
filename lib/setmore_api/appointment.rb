module SetmoreApi
  class Appointment

    REQUEST_PATH = '/bookingapi/appointment'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration&&SetmoreApi.configuration.refreash_token
    end
    
    def create_appointment appointment_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless (appointmentattributes[:staff_key]appointmentattributes[:service_key]&&
        appointmentattributes[:customer_key]&&appointmentattributes[:start_time]&&appointmentattributes[:end_time])
      params = {
        :request_path => (REQUEST_PATH+"/create"),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :body_data => appointmentattributes
      }
      response = Connection.new.post(params)
      fail "Unable to create appointment, error: #{response['error']}" unless response && response['response'] 
      response['data']['appointment']
    end

    def update_appointment_label appointment_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Require params missing' unless appointment_attributes[:appointment_key]&&appointment_attributes[:label]

      params = {
        :request_path => (REQUEST_PATH+"s/#{appointment_attributes.delete(:appointment_key)}/label"),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => appointment_attributes
      }
      response = Connection.new.put(params)
    end


    def get_appointment appointment_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless appointment_attributes[:first_name]
      params = {
        :request_path => (REQUEST_PATH),         
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => appointment_attributes
      }
      response = Connection.new.get(params)
      fail "Unable to get appointment, error: #{response['error']}" unless response && response['response'] 
      response['data']['appointment']
    end

  end
end