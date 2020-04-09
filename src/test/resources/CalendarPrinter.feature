Feature: CalendarPrinter

  Background:
    Given a calendar printer

  # ----------------------------------------------- Print time -----------------------------------------------

  Scenario Outline: Printing valid time string
    When print time from <input>
    Then printing should succeed
    And printed time should be equal to <result>
    Examples:
      | input | result    |
      | 0     | "'00:00'" |
      | 1     | "'00:01'" |
      | 60    | "'01:00'" |
      | 61    | "'01:01'" |
      | 1439  | "'23:59'" |
      | 1440  | "'24:00'" |

  Scenario Outline: Printing invalid time string
    When print time from <input>
    Then printing should failed
    And printing exception is instance of "ru.shishkin.calendars.CalendarPrinter$Exception"
    And printing exception has message "<message>"
    And printing exception root is instance of "<root exception>"
    And printing exception root has message "<root message>"
    Examples:
      | input | message                    | root exception           | root message                                      |
      | -1    | Failed to print time: -1   | java.lang.AssertionError | Wrong time value, it should be in [0, 1440]: -1   |
      | -2    | Failed to print time: -2   | java.lang.AssertionError | Wrong time value, it should be in [0, 1440]: -2   |
      | 1441  | Failed to print time: 1441 | java.lang.AssertionError | Wrong time value, it should be in [0, 1440]: 1441 |
      | 1442  | Failed to print time: 1442 | java.lang.AssertionError | Wrong time value, it should be in [0, 1440]: 1442 |

  # ----------------------------------------------- Print period -----------------------------------------------

  Scenario Outline: Printing valid period string
    When print period from <input>
    Then printing should succeed
    And printed period should be equal to "<result>"
    Examples:
      | input        | result             |
      | [0, 1]       | ['00:00', '00:01'] |
      | [1438, 1439] | ['23:58', '23:59'] |
      | [1439, 1440] | ['23:59', '24:00'] |
      | [0, 1440]    | ['00:00', '24:00'] |

  Scenario Outline: Printing invalid period string
    When print period from <input>
    Then printing should failed
    And printing exception is instance of "ru.shishkin.calendars.CalendarPrinter$Exception"
    And printing exception has message "<message>"
    And printing exception root is instance of "<root exception>"
    And printing exception root has message "<root message>"
    Examples:
      | input        | message                              | root exception           | root message                                                                |
      | <NULL>       | Failed to print period: null         | java.lang.AssertionError | Wrong period value, it can't be null                                        |
      | []           | Failed to print period: []           | java.lang.AssertionError | Wrong period, should contain start and end times: []                        |
      | [1]          | Failed to print period: [1]          | java.lang.AssertionError | Wrong period, should contain start and end times: [1]                       |
      | [2, 1]       | Failed to print period: [2, 1]       | java.lang.AssertionError | Wrong period duration, start time can't be after the end time: [2, 1]       |
      | [1439, 1438] | Failed to print period: [1439, 1438] | java.lang.AssertionError | Wrong period duration, start time can't be after the end time: [1439, 1438] |
      | [0, 0]       | Failed to print period: [0, 0]       | java.lang.AssertionError | Wrong period duration, start time can't be equal the end time: [0, 0]       |
      | [1, 1]       | Failed to print period: [1, 1]       | java.lang.AssertionError | Wrong period duration, start time can't be equal the end time: [1, 1]       |

  # ----------------------------------------------- Print calendar -----------------------------------------------

  Scenario Outline: Printing valid calendar string
    When print calendar from <input>
    Then printing should succeed
    And printed calendar should be equal to "<result>"
    Examples:
      | input                  | result                                   |
      | []                     | []                                       |
      | [[0, 1]]               | [['00:00', '00:01']]                     |
      | [[0, 1440]]            | [['00:00', '24:00']]                     |
      | [[0, 1], [1438, 1439]] | [['00:00', '00:01'], ['23:58', '23:59']] |
      | [[1438, 1439]]         | [['23:58', '23:59']]                     |

  Scenario Outline: Printing invalid calendar string
    When print calendar from <input>
    Then printing should failed
    And printing exception is instance of "ru.shishkin.calendars.CalendarPrinter$Exception"
    And printing exception has message "<message>"
    And printing exception root is instance of "<root exception>"
    And printing exception root has message "<root message>"
    Examples:
      | input  | message                        | root exception           | root message                           |
      | <NULL> | Failed to print calendar: null | java.lang.AssertionError | Wrong calendar value, it can't be null |
