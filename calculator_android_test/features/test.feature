Feature: Basic test

  @regression @C000001
  Scenario Outline: I could do basic calculations
    Given I see main activity page
    When I calculate <op>
    Then I see the text of result is <result>

    Examples:
      | op    | result |
      | 1+2   | 3      |
      | 10-40 | -30    |
      | 10/5  | 2      |
      | 100*3 | 300    |
