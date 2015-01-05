module JsonHelper

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def json_request_headers(token)
    { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => "Token token=#{token}" }
  end

end

RSpec.configure do |config|
  config.include JsonHelper, type: :request
end

