require 'spec_helper'

class Form #simulating Mechanize::Form
  attr_accessor :email, :password
  def submit;end
end

describe Yelp::Web do

  describe '#login' do

    let(:mechanize){ Mechanize.new }

    before(:each){
      mechanize.stub(:get)
      Mechanize.stub(:new).and_return( mechanize )
    }

    it 'should return success message if login valid' do
      mechanize.stub_chain(:page, :form_with).and_return( Form.new )
      mechanize.stub_chain(:page, :link_with).and_return( true )

      result = Yelp::Web.login( username: 'me@example.com', password: 'secret' )
      result.should eql( Yelp::Web::MSG[:success] )
    end

    it 'should return failed message if login invalid' do
      mechanize.stub_chain(:page, :form_with).and_return( false )

      result = Yelp::Web.login( username: 'me@example.com', password: 'secret' )
      result.should eql( Yelp::Web::MSG[:failed] )
    end

    it 'should show message of internet connection unavailability' do
      result = mechanize.stub(:get).and_raise( Net::HTTP::Persistent::Error )

      result = Yelp::Web.login( username: 'me@example.com', password: 'secret' )
      result.should eql( Yelp::Web::MSG[:connection_error] )
    end
    
  end
end