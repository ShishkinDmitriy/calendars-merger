Feature: CalendarMerger

  Background:
    Given a calendar merger

  Scenario Outline: Default merge
    When merge <calendar 1> with <bounds 1> with <calendar 2> with <bounds 2> with <duration>
    Then merging should succeed
    And merged calendar should be equal to <result>
    Examples:
      | calendar 1  | bounds 1  | calendar 2  | bounds 2    | duration | result        |
      | []          | [0, 1440] | []          | [0, 1440]   | 1        | [[0, 1440]]   |
      | []          | [0, 1000] | []          | [500, 1440] | 1        | [[500, 1000]] |
      | []          | [0, 1440] | []          | [0, 1440]   | 1440     | [[0, 1440]]   |
      | [[0, 1440]] | [0, 1440] | []          | [0, 1440]   | 1        | []            |
      | []          | [0, 1440] | [[0, 1440]] | [0, 1440]   | 1        | []            |

  Scenario Outline: Default merge bounds
    When merge bounds <calendar> with <bounds>
    Then merging should succeed
    And merged calendar should be equal to <result>
    Examples:
      | calendar                | bounds     | result                                |
      | []                      | [0, 1440]  | [[0, 0], [1440, 1440]]                |
      | [[0, 1440]]             | [0, 1440]  | [[0, 1440], [1440, 1440]]             |
      | []                      | [60, 61]   | [[0, 60], [61, 1440]]                 |
      | [[100, 500]]            | [100, 500] | [[0, 500], [500, 1440]]               |
      | [[0, 100], [500, 1000]] | [100, 500] | [[0, 100], [500, 1440]]               |
      | [[0, 100], [500, 1000]] | [50, 1440] | [[0, 100], [500, 1000], [1440, 1440]] |
      | [[0, 100], [101, 1000]] | [100, 101] | [[0, 100], [101, 1440]]               |
