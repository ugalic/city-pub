module Yelp
  class Service
    attr_accessor :search

    def initialize( options )
      oauth_config  = Yelp::Api::Config.new( options )
      self.search   = Yelp::Api::Search.new( oauth_config )
    end

    def popular_pub_in( city = 'London')
      response  = self.search.pub( city )
      Yelp::Api::Results.new( response ).pub
    end

  end

end
