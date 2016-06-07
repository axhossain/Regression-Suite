require 'pry'
require "net/http"
require "net/https"
require "uri"
require "json"

class ApiCall
  def self. api_call(type,resource)
    uri = URI.parse("#{END_POINT[:end_point]}/#{resource}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.add_field('Content-Type', 'application/json')
    request.basic_auth(API_AUTH_CREDENTIALS[:username], API_AUTH_CREDENTIALS[:password])
    request.body = request_body(type)
    response = http.request(request)
    puts request.body
    puts response.code
    puts response.message
  end
end

def request_body(type)
  case type
    when "qanda"
      $request_body = {:type=>"qna",:subject=> "#{$subject_line}",
                       :priority=>4,:status=>"open",:labels=> ["QNA"],
                       :message=>{:subject=> "subject_line", :body=> "Example body",                                                                                                                        :_links=> { :topic=> { :href=> "/api/v2/topics/32", :class=> "topic" }}},
                       :_links=>{:customer=>{:class=>"customer",:href=>"/api/v2/customers/24"}}}.to_json
  end
end
