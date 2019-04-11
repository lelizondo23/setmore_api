module SetmoreApi
  class Connection

    SETMORE_URI= 'https://developer.setmore.com/api/v1'

    def initialize
      fail 'SetmoreApi not configured yet!' unless SetmoreApi.configuration && SetmoreApi.configuration.refresh_token
    end

    def execute params,http_request_method
      uri = URI.parse(SETMORE_URI + params.delete(:request_path))
      uri.query = URI.encode_www_form(params[:query_params]) if params.key?(:query_params)
      @req = "Net::HTTP::#{http_request_method}".constantize.new(uri.to_s)
      @req.body = params[:body_data].to_json if params.key?(:body_data)
      set_headers params.delete(:headers) if params.key?(:headers)
      make_request uri
    end

    private

    def set_headers headers
      headers.map { |key, value| @req[key] = value }
    end

    def make_request uri
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
        http.request(@req)
      }
      JSON.parse(response.body)
    end

  end
end