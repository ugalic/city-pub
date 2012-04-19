require 'mechanize'

module Yelp
  class Web
    attr_accessor :consumer, :access_token, :body, :city

    LOGIN_PAGE = 'http://yelp.co.uk/login'

    MSG = {
      success: 'Your account details are valid',
      failed: 'Failed to log in to Yelp',
      connection_error: 'Could not connect to the internet' }

    def self.login( params )
      login_valid = false
      email, password = params[:username], params[:password]
      #using mechanize in order to post csrftoken param
      agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
      agent.get( LOGIN_PAGE )

      #extract login-form
      login_form = agent.page.form_with( id: 'login-form' )
      if login_form
        login_form.email = email
        login_form.password = password
        login_form.submit
        login_valid = agent.page.link_with( id: 'logout-link') != nil
      end

      login_valid ? MSG[:success] : MSG[:failed]
    rescue Net::HTTP::Persistent::Error => e
      MSG[:connection_error]
    end

  end
end
