require_relative './constants.rb'
require 'open-uri'
require 'json'

module ShapeShift
  class RecentTransactions
    def initialize(limit: 5)
      @limit = limit
    end

    def to_s
      <<-STRING
Time  | From  | To    |     Amount
----- | ----- | ----- | ----------
#{transaction_rows}
      STRING
    end

    def transaction_rows
      parsed_response
        .map do |t|
        "#{time(t)} | #{symbols(t)} | #{amount(t)}"
      end
        .join("\n")
    end

    def time(t)
      Time
        .at(t["timestamp"])
        .strftime("%I:%M")
        .rjust(5, ' ')
    end

    def amount(t)
      t["amount"]
        .to_f
        .round(1)
        .to_s
        .rjust(10, ' ')
    end

    def symbols(t)
      [
        t["curIn"],
        t["curOut"]
      ].map do |symbol|
        symbol
          .upcase
          .rjust(5, " ")
      end
        .join(' | ')
    end

    def parsed_response
      @parsed_response ||= JSON::parse(response)
    end

    def response
      open("#{URL}/recenttx/#{@limit}").read
    end
  end
end
