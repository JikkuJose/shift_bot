require 'open-uri'
require 'json'
require_relative './constants.rb'

module ShapeShift
  class Rate
    def initialize(from:, to:)
      @from = from.upcase
      @to = to.upcase
    end

    def to_s
      "#{rate} #{@to}"
    end

    def rate
      JSON::parse(response)["rate"]
    end

    def response
      open("#{URL}/rate/#{pair}").read
    end

    def pair
      "#{@from}_#{@to}"
    end
  end
end
