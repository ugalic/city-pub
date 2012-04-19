Feature: Logging in to Yelp with email addresses and passwords

  Scenario Outline: Successfully logging in with a valid email and password
    When I run `yelp login <Email_Address <Password>`
    Then the output should contain "Your account details are valid"
    
  Scenario Outline: Failing to log in to Yelp due to an invalid email or password
    When I run `yelp login <Email_Address> <Password>`
    Then the output should contain "Failed to log in to Yelp"
    
  Examples:
    | Email_Address     | Password         |
    | <your email>      | <your password>  |
