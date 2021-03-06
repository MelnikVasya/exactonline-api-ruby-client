require "faraday"

module Elmas
  class Client < API
    def connection
      Faraday.new do |faraday|
        faraday.request :multipart
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
