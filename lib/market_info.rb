require_relative './constants.rb'
require 'json'
require 'open-uri'

module ShapeShift
  class MarketInfo
    def initialize(from:, to:)
      @from = from.upcase
      @to = to.upcase
    end

    def to_s
      <<-STRING
Pair     : #{@from} - #{@to}
Rate     : #{rate}
Limit    : #{limit}
Minimum  : #{minimum}
Miner fee: #{miner_fee}
      STRING
    end

    def rate
      parsed_response["rate"]
    end

    def limit
      parsed_response["limit"]
    end

    def minimum
      parsed_response["minimum"]
    end

    def miner_fee
      parsed_response["minerFee"]
    end

    def parsed_response
      @parsed_response ||= JSON::parse(response)
    end

    def response
      open("#{URL}/marketinfo/#{pair}").read
    end

    def pair
      "#{@from}_#{@to}"
    end
  end
end
