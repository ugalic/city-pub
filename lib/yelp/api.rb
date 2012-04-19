require 'oauth'
require 'json'

module Yelp
  class Api

    attr_accessor :consumer, :access_token, :body

    PATH  = '/v2/search?term=pubs&sort=2&cc=GB&location=__CITY__'
    MSG = {
      connection_error: 'Could not connect to the internet',
      no_results: 'No matching results' }

      def initialize( options )
        @body = "", ""
        @consumer = OAuth::Consumer.new( options[:consumer_key], options[:consumer_secret], {:site => "http://#{options[:api_host]}"} )
        @access_token = OAuth::AccessToken.new( @consumer, options[:token], options[:token_secret] )
      end

      def popular_pub_in( city = 'London')
        path = PATH.gsub( '__CITY__', city )
        @body = @access_token.get( path ).body
        @body.include?('error') ? JSON.parse(@body)['error']['text'] : results
      rescue SocketError => e
        MSG[:connection_error]
      rescue Exception => e
        "[#{e.class}] - #{e.message}"
      end

      def results
        business = {}
        @body = JSON.parse( @body )
        unless @body['businesses'].empty?
          business = @body['businesses'].first #we are interested just in first result
          business['location']['address'] << business['location']['postal_code']
        end

        business.empty? ? MSG[:no_results] : prepare_output( business )
      end

      def prepare_output( business )
        neighborhoods = business['location']['neighborhoods']  unless business['location']['neighborhoods'].nil?
        output =
"""
The highest rated pub in #{business['location']['city']} is:

================================================================================
#{business['name']} - #{ !neighborhoods.nil? ? neighborhoods.join(', ') : 'N/A'}
================================================================================

#{business['location']['address'].join(', ')}
#{business['phone']}

#{business['rating']} stars

================================================================================
"""
        output
      end

    end

  end
