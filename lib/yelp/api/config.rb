module Yelp
  module Api

    class Config
      attr_accessor :consumer_key, :consumer_secret, :api_host, :token, :token_secret

      def initialize( args )
        @consumer_key       = args[:consumer_key]
        @consumer_secret    = args[:consumer_secret]
        @api_host           = args[:api_host]
        @token              = args[:token]
        @token_secret       = args[:token_secret]
      end

    end
  end
end
