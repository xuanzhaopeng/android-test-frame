Feature: Calculation

  @regression @C000001
  Scenario Outline: I see default view when I tap calculation button with empty arguments
    Given I set scenario key "<op>"
    Given I see main activity page
    When I tap on <op> button
    Then I see main activity page

    Examples:
      | op             |
      | add            |
      | sub            |
      | division       |
      | multiplication |

  @regression @C000002
  Scenario Outline: I see default view when I tap calculation button with only 1 filled argument
    Given I set scenario key "<op><arg_index>"
    Given I see main activity page
    When I type 10 to <arg_index> argument
    And I tap on <op> button
    Then I see main activity page

    Examples:
      | op             | arg_index |
      | add            | first     |
      | add            | second    |
      | sub            | first     |
      | sub            | second    |
      | division       | first     |
      | division       | second    |
      | multiplication | first     |
      | multiplication | second    |

  @regression @C000003
  Scenario Outline: Calculator could accept valid number and refuse/correct invalid number
    Given I set scenario key "<key>"
    Given I see main activity page
    When I type <value> to first argument
    And I type <value> to second argument
    Then I see the text of first argument is <expect_number>
    And I see the text of second argument is <expect_number>

    Examples:
      | key      | value                                                                            | expect_number                                                                    |
      | valid1   | 1                                                                                | 1                                                                                |
      | valid2   | -1                                                                               | -1                                                                               |
      | valid3   | 1000000000000000000000000000000000000000000000000000000000000000000000000000000  | 1000000000000000000000000000000000000000000000000000000000000000000000000000000  |
      | valid4   | -1000000000000000000000000000000000000000000000000000000000000000000000000000000 | -1000000000000000000000000000000000000000000000000000000000000000000000000000000 |
      | valid5   | 0.1                                                                              | 0.1                                                                              |
      | valid6   | 0                                                                                | 0                                                                                |
      | invalid1 | 01                                                                               | 1                                                                                |
      | invalid2 | 00001                                                                            | 1                                                                                |
      | invalid3 | .5                                                                               | 0.5                                                                              |

  @regression @C000004
  Scenario Outline: I could do add/sub/mul/div calculations
    Given I set scenario key "<key>"
    Given I see main activity page
    When I calculate <op>
    Then I see the text of result is <result>

    Examples:
      | key  | op                                                                                  | result       |
      | add1 | 1 + 2                                                                               | 3            |
      | add2 | 1000000000000000000000000000000000000000000000000000000000000000000000000000000 + 1 | 1e78         |
      | add3 | -10 + -20                                                                           | -30          |
      | add4 | 0.5 + 0.6                                                                           | 1.1          |
      | add5 | -5 + 5                                                                              | 0            |
      | sub1 | 40 - 10                                                                             | 30           |
      | sub2 | 10 - 40                                                                             | -30          |
      | sub3 | 1 - 1000000000000000000000000000000000000000000000000000000000000000000000000000000 | -1e78        |
      | sub4 | -10 - -20                                                                           | 10           |
      | sub5 | 0.3 - 0.4                                                                           | -0.1         |
      | mul1 | 100 * 3                                                                             | 300          |
      | mul2 | 1000000000000000000000000000000000000000000000000000000000000000000000000000000 * 3 | 3e78         |
      | mul3 | -10 * -10                                                                           | 100          |
      | mul4 | -10 * 10                                                                            | -100         |
      | mul5 | 10 * 0.523                                                                          | 5.23         |
      | mul6 | 0.1 * 0.523                                                                         | 0.0523       |
      | div1 | 10 / 5                                                                              | 2            |
      | div2 | 5 / 10                                                                              | 0.5          |
      | div3 | 3 / 10                                                                              | 0.3          |
      | div4 | 0 / 10                                                                              | 0            |
      | div5 | 10 / 0                                                                              | Not a number |
      | div6 | 0.1 / 0.001                                                                         | 100          |
      | div6 | 1 / 1000000000000000000000000000000000000000000000000000000000000000000000000000000 | 1e-78        |
      | div7 | 1000000000000000000000000000000000000000000000000000000000000000000000000000000 / 1 | 1e78         |
      | div8 | -10 / -10                                                                           | 1            |
      | div9 | -10 / 10                                                                            | -1           |

  @regression @C000005
  Scenario Outline: I see the arguments be used continuously
    Given I set scenario key "<key>"
    Given I see main activity page
    Given I type <arg1> to first argument
    Given I type <arg2> to second argument
    When I tap on add button
    Then I see the text of result is <add_result>
    When I tap on sub button
    Then I see the text of result is <sub_result>
    When I tap on division button
    Then I see the text of result is <div_result>
    When I tap on multiplication button
    Then I see the text of result is <mul_result>

    Examples:
      | key | arg1 | arg2 | add_result | sub_result | div_result | mul_result |
      | t1  | 2    | 4    | 6          | -2         | 0.5        | 8          |
      | t2  | 4    | 2    | 6          | 2          | 2          | 8          |

  @regression @C000006
  Scenario: I could change arguments during calculation
    Given I see main activity page
    When I type 1 to first argument
    And I type 2 to second argument
    And I clear text and type 3 to first argument
    And I tap on add button
    Then I see the text of result is 5
    When I clear text and type 3 to second argument
    And I tap on division button
    Then I see the text of result is 1
    When I clear text and type 30 to first argument
    And I tap on multiplication button
    Then I see the text of result is 90
    When I clear text and type 5 to second argument
    And I tap on sub button
    Then I see the text of result is 25
