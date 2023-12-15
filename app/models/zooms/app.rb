class Zooms::App
  def initialize(topic, start_time)
    @topic = topic
    @start_time = start_time
  end

  TIME_ZONE = 'Asia/Tokyo'.freeze

  require 'net/http'
  require 'base64'

  def create!
    response = post_api_request
    body = JSON.parse(response.body)
    raise StandardError, body['error'] unless response.code == '201'

    body
  end

  private

  def headers
    token = create_access_token!
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json'
    }
  end

  def post_api_request
    uri = URI.parse(api_request_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    http.post(uri.path, request_body.to_json, headers)
  end
  
  def create_access_token!
    response = token_request

    body = JSON.parse(response.body)
    if response.code == '200'
      body['access_token']
    else
      raise StandardError, body['error']
    end
  end

  def token_request
    uri = URI.parse('https://zoom.us/oauth/token')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === 'https'

    http.post(uri.path, token_request_query.to_param, token_request_headers)
  end

  def token_request_query
    {
      grant_type: 'account_credentials',
      account_id:,
    }
  end

  def token_request_headers
    {
      'authorization' => "Basic #{credentials}",
      'content-type' => 'application/x-www-form-urlencoded'
    }
  end

  def api_request_url
    "https://api.zoom.us/v2/users/#{owner_email}/meetings"
  end

  def request_body
    # https://marketplace.zoom.us/docs/api-reference/zoom-api/methods/#operation/meetingCreate
    {
      topic: @topic,
      type: '2',
      start_time: @start_time, # yyyy-MM-ddTHH:mm:ss
      timezone: TIME_ZONE,
      duration: 30, # 所要時間
      password:,
    }
  end

  def password
    random = Random.new
    random.rand(9_999_999_999)
  end

  def credentials
    Base64.strict_encode64("#{client_id}:#{client_secret}")
  end

  def account_id
    Rails.application.credentials.api[:account_id]
  end

  def client_id
    Rails.application.credentials.api[:client_id]
  end

  def client_secret
    Rails.application.credentials.api[:client_secret]
  end

  def owner_email
    Rails.application.credentials.api[:owner_email]
  end
end
