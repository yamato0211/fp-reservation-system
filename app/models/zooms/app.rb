module Zooms
  class App
    def initialize(topic, start_time)
      @topic = topic
      @start_time = start_time
      @client = HttpClient.new
    end

    class RequestFailed < StandardError; end

    TIME_ZONE = 'Asia/Tokyo'.freeze
    OWNER_EMAIL = Rails.application.credentials.api[:owner_email]
    API_REQUEST_URL = "https://api.zoom.us/v2/users/#{OWNER_EMAIL}/meetings"

    def create!
      token = @client.create_access_token!
      response = @client.post(API_REQUEST_URL, request_body, headers(token))
      body = JSON.parse(response.body)
      raise RequestFailed, body['error'] unless response.code == '201'

      body
    end

    private

    def headers(token)
      {
        Authorization: "Bearer #{token}",
        'Content-Type': 'application/json'
      }
    end

    def request_body
      {
        topic: @topic,
        type: '2', # スケジュールされたミーティング
        start_time: @start_time, # yyyy-MM-ddTHH:mm:ss
        timezone: TIME_ZONE,
        duration: 30, # 所要時間
        password: password
      }
    end

    def password
      random = Random.new
      random.rand(9_999_999_999)
    end
  end
end
