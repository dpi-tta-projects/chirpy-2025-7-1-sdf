require "http"
require "json"

class IpStack
  def self.lookup(ip_address)
    return {} if ip_address == "::1" # localhost

    response = HTTP.get("http://api.ipstack.com/#{ip_address}?access_key=#{ENV["IP_STACK_ACCESS_KEY"]}")

    JSON.parse(response.to_s)
  end
end
