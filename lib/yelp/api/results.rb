require 'json'

module Yelp
  module Api
    class Results
      def initialize( args )
        @body = args
      end
      
      def pub
        return JSON.parse(@body)['error']['text'] if @body.include?('error')
        business = {}
        @body = JSON.parse( @body )
        unless @body['businesses'].empty?
          business = @body['businesses'].first #we are interested just in first result
          business['location']['address'] << business['location']['postal_code']
        end

        business.empty? ? [] : prepare_output( business )
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
end