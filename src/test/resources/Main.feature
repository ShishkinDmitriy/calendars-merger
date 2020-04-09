Feature: Main

  Scenario Outline: Default program usage
    When user starts program
    And user types line "<calendar 1>" in console
    And user types line "<bounds 1>" in console
    And user types line "<calendar 2>" in console
    And user types line "<bounds 2>" in console
    And user types line "<duration>" in console
    And user press enter
    Then program finished successfully
    And program should print "<result>"
    Examples:
      | calendar 1                                                | bounds 1          | calendar 2                                                                | bounds 2          | duration | result                                                       |
      | []                                                        | ['00:00','24:00'] | []                                                                        | ['00:00','24:00'] | 1        | [['00:00', '24:00']]                                         |
      | []                                                        | ['00:00','24:00'] | []                                                                        | ['00:00','24:00'] | 1440     | [['00:00', '24:00']]                                         |
      | []                                                        | ['00:00','24:00'] | [['00:00', '24:00']]                                                      | ['00:00','24:00'] | 1        | []                                                           |
      | [['00:00','24:00']]                                       | ['00:00','24:00'] | []                                                                        | ['00:00','24:00'] | 1        | []                                                           |
      | [['09:00','10:30'],['12:00', '13:00'],['16:00', '18:00']] | ['09:00','20:00'] | [['10:00','11:30'],['12:30','14:30'],['14:30','15:00'],['16:00','17:00']] | ['10:00','18:30'] | 30       | [['11:30', '12:00'], ['15:00', '16:00'], ['18:00', '18:30']] |
