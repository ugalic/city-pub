require 'json'

module Yelp
  module Api
    class Results
      
      NO_RESULTS = { 'msg' => 'No matching results' }
      
      def initialize( args )
        @body = args
      end
      
      def pub
        parsed_response = parse_response
        return parsed_response if !parsed_response.kind_of?(Hash) || parsed_response.nil?
        business = {}
        unless parsed_response['businesses'].empty?
          business = parsed_response['businesses'].first #we are interested just in first result
          business['location']['address'] << business['location']['postal_code']
        end
        
        business.empty? ? NO_RESULTS['msg'] : prepare_output( business )
      end
      
      def parse_response
        response = nil
        if @body.include?('error')
          response = JSON.parse(@body)['error']['text']
        elsif @body.include?('msg')
          response = @body['msg']
        else
          response = JSON.parse( @body )
        end
        response
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