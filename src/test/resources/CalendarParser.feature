Feature: CalendarParser

  Background:
    Given a calendar parser

  # ----------------------------------------------- Parse time -----------------------------------------------

  Scenario Outline: Parsing valid time string
    When parse time from <input>
    Then parsing should succeed
    And parsed time should be equal to <result>
    Examples:
      | input            | result |
      | "'00:00'"        | 0      |
      | "'0:0'"          | 0      |
      | "' 00 : 00 '"    | 0      |
      | "'00:01'"        | 1      |
      | "'0:1'"          | 1      |
      | "'01:00'"        | 60     |
      | "'01:01'"        | 61     |
      | "'23:59'"        | 1439   |
      | "'  23 : 59 '  " | 1439   |
      | "'24:00'"        | 1440   |
      | "\"24:00\""      | 1440   |

  Scenario Outline: Parsing invalid time string
    When parse time from <input>
    Then parsing should failed
    And parsing exception is instance of "ru.shishkin.calendars.CalendarParser$Exception"
    And parsing exception has message "<message>"
    And parsing exception root is instance of "<root exception>"
    And parsing exception root has message "<root message>"
    Examples:
      | input      | message                            | root exception                  | root message                                |
      | <NULL>     | Failed to parse time: null         | java.lang.AssertionError        | Wrong time value, it can't be null or blank |
      | ""         | Failed to parse time: \"\"         | java.lang.AssertionError        | Wrong time value, it can't be null or blank |
      | " "        | Failed to parse time: \" \"        | java.lang.AssertionError        | Wrong time value, it can't be null or blank |
      | "     "    | Failed to parse time: \"     \"    | java.lang.AssertionError        | Wrong time value, it can't be null or blank |
      | "'-2:00'"  | Failed to parse time: \"'-2:00'\"  | java.lang.AssertionError        | Wrong time hour value: -2                   |
      | "'-1:00'"  | Failed to parse time: \"'-1:00'\"  | java.lang.AssertionError        | Wrong time hour value: -1                   |
      | "'25:00'"  | Failed to parse time: \"'25:00'\"  | java.lang.AssertionError        | Wrong time hour value: 25                   |
      | "'26:00'"  | Failed to parse time: \"'26:00'\"  | java.lang.AssertionError        | Wrong time hour value: 26                   |
      | "'aa:00'"  | Failed to parse time: \"'aa:00'\"  | java.lang.NumberFormatException | For input string: \"aa\"                    |
      | "'1z:00'"  | Failed to parse time: \"'1z:00'\"  | java.lang.NumberFormatException | For input string: \"1z\"                    |
      | "'01:aa'"  | Failed to parse time: \"'01:aa'\"  | java.lang.NumberFormatException | For input string: \"aa\"                    |
      | "'01:1z'"  | Failed to parse time: \"'01:1z'\"  | java.lang.NumberFormatException | For input string: \"1z\"                    |
      | "'00:-2'"  | Failed to parse time: \"'00:-2'\"  | java.lang.AssertionError        | Wrong time minutes value: -2                |
      | "'00:-1'"  | Failed to parse time: \"'00:-1'\"  | java.lang.AssertionError        | Wrong time minutes value: -1                |
      | "'00:60'"  | Failed to parse time: \"'00:60'\"  | java.lang.AssertionError        | Wrong time minutes value: 60                |
      | "'00:61'"  | Failed to parse time: \"'00:61'\"  | java.lang.AssertionError        | Wrong time minutes value: 61                |
      | "'00:61\"" | Failed to parse time: \"'00:61\"\" | java.lang.AssertionError        | Wrong period commas: \"'00:61\"\"           |
      | "\"00:61'" | Failed to parse time: \"\"00:61'\" | java.lang.AssertionError        | Wrong period commas: \"\"00:61'\"           |
      | "00:61"    | Failed to parse time: \"00:61\"    | java.lang.AssertionError        | Wrong period commas: \"00:61\"              |

  # ----------------------------------------------- Parse period -----------------------------------------------

  Scenario Outline: Parsing valid period string
    When parse period from <input>
    Then parsing should succeed
    And parsed period should be equal to <result>
    Examples:
      | input                        | result       |
      | "['00:00', '00:01']"         | [0, 1]       |
      | " [' 00 : 00',  '00 : 01' ]" | [0, 1]       |
      | "['23:58', '23:59']"         | [1438, 1439] |
      | " [ '23:58' , '23:59 '] "    | [1438, 1439] |
      | "['23:59', '24:00']"         | [1439, 1440] |
      | "['00:00', '24:00']"         | [0, 1440]    |

  Scenario Outline: Parsing invalid period string
    When parse period from <input>
    Then parsing should failed
    And parsing exception is instance of "ru.shishkin.calendars.CalendarParser$Exception"
    And parsing exception has message "<message>"
    And parsing exception root is instance of "<root exception>"
    And parsing exception root has message "<root message>"
    Examples:
      | input                | message                                        | root exception           | root message                                                                      |
      | <NULL>               | Failed to parse period: null                   | java.lang.AssertionError | Wrong period value, it can't be null or blank                                     |
      | ""                   | Failed to parse period: \"\"                   | java.lang.AssertionError | Wrong period value, it can't be null or blank                                     |
      | " "                  | Failed to parse period: \" \"                  | java.lang.AssertionError | Wrong period value, it can't be null or blank                                     |
      | "     "              | Failed to parse period: \"     \"              | java.lang.AssertionError | Wrong period value, it can't be null or blank                                     |
      | "'00:00', '12:00'"   | Failed to parse period: \"'00:00', '12:00'\"   | java.lang.AssertionError | Wrong period format: '00:00', '12:00'                                             |
      | "['00:00', '12:00'"  | Failed to parse period: \"['00:00', '12:00'\"  | java.lang.AssertionError | Wrong period format: ['00:00', '12:00'                                            |
      | "'00:00', '12:00']"  | Failed to parse period: \"'00:00', '12:00']\"  | java.lang.AssertionError | Wrong period format: '00:00', '12:00']                                            |
      | "['00:00'; '01:00']" | Failed to parse period: \"['00:00'; '01:00']\" | java.lang.AssertionError | Wrong period delimiter: ['00:00'; '01:00']                                        |
      | "['00:00' '01:00']"  | Failed to parse period: \"['00:00' '01:00']\"  | java.lang.AssertionError | Wrong period delimiter: ['00:00' '01:00']                                         |
      | "['00:00'. '01:00']" | Failed to parse period: \"['00:00'. '01:00']\" | java.lang.AssertionError | Wrong period delimiter: ['00:00'. '01:00']                                        |
      | "['00:02', '00:01']" | Failed to parse period: \"['00:02', '00:01']\" | java.lang.AssertionError | Wrong period duration, start time can't be after the end time: ['00:02', '00:01'] |
      | "['23:59', '23:58']" | Failed to parse period: \"['23:59', '23:58']\" | java.lang.AssertionError | Wrong period duration, start time can't be after the end time: ['23:59', '23:58'] |
      | "['00:00', '00:00']" | Failed to parse period: \"['00:00', '00:00']\" | java.lang.AssertionError | Wrong period duration, start time can't be equal the end time: ['00:00', '00:00'] |
      | "['00:01', '00:01']" | Failed to parse period: \"['00:01', '00:01']\" | java.lang.AssertionError | Wrong period duration, start time can't be equal the end time: ['00:01', '00:01'] |

  # ----------------------------------------------- Parse calendar -----------------------------------------------

  Scenario Outline: Parsing valid calendar string
    When parse calendar from <input>
    Then parsing should succeed
    And parsed calendar should be equal to <result>
    Examples:
      | input                                      | result                 |
      | "[]"                                       | []                     |
      | "[ ]"                                      | []                     |
      | " [ ] "                                    | []                     |
      | "[['00:00', '00:01']]"                     | [[0, 1]]               |
      | "[['00:00', '00:01'], ['23:58', '23:59']]" | [[0, 1], [1438, 1439]] |
      | "[['23:58', '23:59']]"                     | [[1438, 1439]]         |
      | " [ [ '23:58' , '23:59' ] ]  "             | [[1438, 1439]]         |

  Scenario Outline: Parsing invalid calendar string
    When parse calendar from <input>
    Then parsing should failed
    And parsing exception is instance of "ru.shishkin.calendars.CalendarParser$Exception"
    And parsing exception has message "<message>"
    And parsing exception root is instance of "<root exception>"
    And parsing exception root has message "<root message>"
    Examples:
      | input   | message                             | root exception           | root message                                    |
      | <NULL>  | Failed to parse calendar: null      | java.lang.AssertionError | Wrong calendar value, it can't be null or blank |
      | ""      | Failed to parse calendar: \"\"      | java.lang.AssertionError | Wrong calendar value, it can't be null or blank |
      | " "     | Failed to parse calendar: \" \"     | java.lang.AssertionError | Wrong calendar value, it can't be null or blank |
      | "     " | Failed to parse calendar: \"     \" | java.lang.AssertionError | Wrong calendar value, it can't be null or blank |
