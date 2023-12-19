module Zooms
  class HttpClient
    require 'net/http'
    require 'base64'

    class RequestFailed < StandardError; end

    ACCOUNT_ID = Rails.application.credentials.api[:account_id]
    CLIENT_ID = Rails.application.credentials.api[:client_id]
    CLIENT_SECRET = Rails.application.credentials.api[:client_secret]

    def post(url, body, headers)
      http, uri = setup_http_client(url)
      http.post(uri.path, body.to_json, headers)
    end

    def create_access_token!
      response = token_request

      body = JSON.parse(response.body)
      if response.code == '200'
        body['access_token']
      else
        raise RequestFailed, body['error']
      end
    end

    private

    def token_request
      http, uri = setup_http_client('https://zoom.us/oauth/token')
      http.post(uri.path, token_request_query.to_param, token_request_headers)
    end

    def setup_http_client(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      [http, uri]
    end

    def token_request_query
      {
        grant_type: 'account_credentials',
        account_id: ACCOUNT_ID,
      }
    end

    def token_request_headers
      {
        'authorization' => "Basic #{credentials}",
        'content-type' => 'application/x-www-form-urlencoded'
      }
    end

    def credentials
      Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
    end
  end
end

