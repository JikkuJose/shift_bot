require_relative './constants.rb'
require 'json'
require 'open-uri'

module ShapeShift
  class DepositLimit
    def initialize(from:, to:)
      @from = from.upcase
      @to = to.upcase
    end

    def to_s
      "#{limit} #{@from}"
    end

    def limit
      JSON::parse(response)["limit"]
    end

    def response
      open("#{URL}/limit/#{pair}").read
    end

    def pair
      "#{@from}_#{@to}"
    end
  end
end
