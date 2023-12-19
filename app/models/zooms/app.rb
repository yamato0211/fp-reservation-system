# module Zooms
#   class App
#     def initialize(topic, start_time)
#       @topic = topic
#       @start_time = start_time
#       @client = HttpClient.new
#     end

#     class RequestFailed < StandardError; end

#     TIME_ZONE = 'Asia/Tokyo'.freeze
#     OWNER_EMAIL = Rails.application.credentials.api[:owner_email]

#     def create!
#       token = @client.create_access_token!
#       response = @client.post(api_request_url, request_body, headers(token))
#       body = JSON.parse(response.body)
#       raise RequestFailed, body['error'] unless response.code == '201'

#       body
#     end

#     private

#     def headers(token)
#       {
#         Authorization: "Bearer #{token}",
#         'Content-Type': 'application/json'
#       }
#     end

#     def api_request_url
#       "https://api.zoom.us/v2/users/#{OWNER_EMAIL}/meetings"
#     end

#     def request_body
#       # https://marketplace.zoom.us/docs/api-reference/zoom-api/methods/#operation/meetingCreate
#       {
#         topic: @topic,
#         type: '2',
#         start_time: @start_time, # yyyy-MM-ddTHH:mm:ss
#         timezone: TIME_ZONE,
#         duration: 30, # 所要時間
#         password: password
#       }
#     end

#     def password
#       random = Random.new
#       random.rand(9_999_999_999)
#     end
#   end
# end

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

    def create!
      token = @client.create_access_token!
      response = @client.post(api_request_url, request_body, headers(token))
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

    def api_request_url
      "https://api.zoom.us/v2/users/#{OWNER_EMAIL}/meetings"
    end

    def request_body
      {
        topic: @topic,
        type: '2',
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
