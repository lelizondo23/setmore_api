module SetmoreApi
  class Appointment

    REQUEST_PATH = '/bookingapi/appointment'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refresh_token
    end

    def create appointment_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless (appointmentattributes[:service_key] && appointmentattributes[:customer_key] &&
        appointmentattributes[:start_time] && appointmentattributes[:end_time])

      params = {
        :request_path => (REQUEST_PATH+"/create"),
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :body_data => appointmentattributes
      }

      response = Connection.new.execute(params,'Post')

      fail "Unable to create appointment, error: #{response['error']}, msg: #{response['msg']}" unless response && response['response']

      response['data']['appointment']
    end

    def update_label appointment_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Require params missing' unless appointment_attributes[:appointment_key] && appointment_attributes[:label]

      params = {
        :request_path => (REQUEST_PATH + "s/#{appointment_attributes.delete(:appointment_key)}/label"),
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => appointment_attributes
      }

      response = Connection.new.execute(params,'Put')

      fail "Unable to create appointment, error: #{response['error']} , msg: #{response['msg']}" unless response && response['response'] && response['data']

      response['data']['appointment']
    end


    def get_for_staff appointment_query_params = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless (appointment_query_params[:staff_key] && appointment_query_params[:startDate] &&
        appointment_query_params[:endDate])

      params = {
        :request_path => (REQUEST_PATH + "s"),
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :query_params => appointment_query_params
      }

      response = Connection.new.execute(params,'Get')

      fail "Unable to get appointment, error: #{response['error']} , msg: #{response['msg']}" unless response && response['response'] && response['data']

      response['data']['appointments']
    end

  end
end