require 'oauth'

module Yelp
  module Api

    class Consumer
      attr_accessor :consumer

      def initialize( args )
        @consumer = OAuth::Consumer.new( args.consumer_key, args.consumer_secret, {:site => "http://#{args.api_host}"} )
      end
      
      def origin
        @consumer
      end

    end

    class AccessToken
      attr_accessor :access_token

      def initialize( consumer, args )
        @accessToken = OAuth::AccessToken.new( consumer, args.token, args.token_secret )
      end

      def get( path )
        @accessToken.get( path )
      end
    end

  end
end