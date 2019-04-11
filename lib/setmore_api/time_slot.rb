module SetmoreApi
  class TimeSlot

    REQUEST_PATH = '/bookingapi/slots'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refresh_token
    end
    #get all available time slots for the given service, staff & date for your company
    def get_all_available slots_attributes = {}
      fail 'Acess Token expired' if SetmoreApi::Token.is_expired?
      fail 'Required params missing' unless (slots_attributes[:staff_key] && slots_attributes[:service_key] && slots_attributes[:selected_date])
      params = {
        :request_path => REQUEST_PATH,
        :headers => {
          'Authorization' => "Bearer #{SetmoreApi.configuration.access_token}",
          'Content-Type' => 'application/json'
        },
        :body_data => slots_attributes
      }

      response = Connection.new.execute(params,'Post')

      fail "Unable to get access slots, error: #{response['error']} , message: #{response['msg']}" unless response && response['response'] && response['data']

      response['data']['slots']
    end

  end
end