Feature: Finding popular pubs

  Scenario Outline: Find the most popular pub in <City>
    When I run `yelp pub <City>`
    Then the output should contain:
"""
The highest rated pub in <City> is:

================================================================================
<Name> - <Location>
================================================================================

<Address>
<Phone>

<Rating> stars

================================================================================
"""
  Examples:
    | City      | Name          | Location      | Address                                     | Phone         | Rating |
    | London    | The Harp      | Strand        | 47 Chandos Place, Covent Garden, WC2N 4HS   | 02078360291   | 4.5    |
    | Cambridge | Free Press    | N/A           | 7 Prospect Row, CB1 1DU                     | 01223368337   | 4.5    |
    | Liverpool | The Jacaranda | N/A           | 21 - 23 Slater Street, L1 4BW               | 01517089424   | 4.5    |

