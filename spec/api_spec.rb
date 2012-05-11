require 'spec_helper'

api_result = "{\"businesses\":[{\"rating\":4.5,\"mobile_url\":\"http://m.yelp.co.uk/biz/the-harp-london-2\",\"rating_img_url\":\"http://media4.ak.yelpcdn.com/static/201012163106483837/img/ico/stars/stars_4_half.png\",\"review_count\":15,\"name\":\"The Harp\",\"rating_img_url_small\":\"http://media4.ak.yelpcdn.com/static/201012161127761206/img/ico/stars/stars_small_4_half.png\",\"url\":\"http://www.yelp.co.uk/biz/the-harp-london-2\",\"phone\":\"+442078360291\",\"snippet_text\":\"Two very potent words for you... WHISKEY CIDER\\n\\nThis place serves it and it will knock you for six! Two pints of this murky nectar and you are well on your...\",\"image_url\":\"http://s3-media3.ak.yelpcdn.com/bphoto/79dUBj_tu3rfGIg60dNjDQ/ms.jpg\",\"snippet_image_url\":\"http://s3-media3.ak.yelpcdn.com/photo/dkfDZy9BmpZqX1jtvMwyfw/ms.jpg\",\"display_phone\":\"+44 20 7836 0291\",\"rating_img_url_large\":\"http://media2.ak.yelpcdn.com/static/201012162752244354/img/ico/stars/stars_large_4_half.png\",\"id\":\"the-harp-london-2\",\"categories\":[[\"British\",\"british\"],[\"Pubs\",\"pubs\"]],\"location\":{\"city\":\"London\",\"display_address\":[\"47 Chandos Place\",\"Covent Garden\",\"Strand\",\"London WC2N 4HS\",\"UK\"],\"geo_accuracy\":8,\"neighborhoods\":[\"Strand\"],\"postal_code\":\"WC2N 4HS\",\"country_code\":\"GB\",\"address\":[\"47 Chandos Place\",\"Covent Garden\"],\"coordinate\":{\"latitude\":51.509700600000002,\"longitude\":-0.12574630000000001},\"state_code\":\"XGL\"}}]}"
api_result_empty = "{\"region\":{\"span\":{\"latitude_delta\":0.010664386215935906,\"longitude_delta\":0.025577545166015625},\"center\":{\"latitude\":65.533338944255831,\"longitude\":-148.53335380554199}},\"total\":0,\"businesses\":[]}"

describe Yelp::Service do

  let(:service){ Yelp::Service.new( {:consumer_key=>"consumer_key", :consumer_secret=>"secret_key", :token=>"token", :token_secret=>"token_secret", :api_host=>"api_host"} ) }

  it 'should setup oauth' do
    service.search.should_not be_nil
    service.search.should be_kind_of Yelp::Api::Search
  end

  it 'should execute search for "London" pub' do
    city = 'London'
    service.search.stub( :pub ).and_return( api_result )
    service.search.should_receive( :pub ).with( city )
    
    service.popular_pub_in( city )
  end
  
  # it 'should notify user if no matching results' do
  #     api.access_token.stub_chain(:get, :body).and_return( api_result_empty )
  #     result = api.popular_pub_in( 'Not a City' )
  #     result.should eql('No matching results')
  #   end
  
  xit 'should notify user if no matching results' do
    service.search.stub( :pub ).and_return( api_result )
    result = service.popular_pub_in( 'Not a City' )
    result.should eql('No matching results')
  end
  
  
  xit 'should set neighborhoods to N/A if no neighborhoods present' do
    json_pub = JSON.parse( api_result )['businesses'].first
    json_pub['location'].delete('neighborhoods')
    output = api.prepare_output( json_pub )
    output.should match(/N\/A/)
  end
  
  xit 'should notify due connection error' do
    api.access_token.stub(:get).and_raise( SocketError )
    result = api.popular_pub_in( 'London' )
    
    result.should eql('Could not connect to the internet')
  end

end