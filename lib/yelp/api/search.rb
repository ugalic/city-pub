module Yelp
  module Api
    class Search
      attr_accessor :results, :access_token, :body

      PATH  = '/v2/search?term=pubs&sort=2&cc=GB&location=__CITY__'
      MSG = {
        connection_error: 'Could not connect to the internet',
        no_results: 'No matching results' }

      def initialize( args )
        consumer = Yelp::Api::Consumer.new( args )
        @access_token = Yelp::Api::AccessToken.new( consumer.origin , args )
      end

      def pub( city )
        path = PATH.gsub( '__CITY__', city )
        @access_token.get( path ).body
      rescue SocketError => e
        MSG[:connection_error]
      rescue Exception => e
        "[#{e.class}] - #{e.message}"
      end

    end
  end
end
