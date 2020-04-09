package ru.shishkin.calendars;

import io.cucumber.java8.En;

import static org.assertj.core.api.Assertions.assertThat;
import static ru.shishkin.calendars.util.CommonStepsDefinition.wrap;

public class CalendarParserStepsDefinition implements En {

    private CalendarParser parser;
    private Object result;
    private Throwable exception;

    {
        // @formatter:off
        Given("a calendar parser",                       () -> parser = new CalendarParser());
        When("parse time from {}",                       (String value) -> wrap(() -> result = parser.parseTime(value), e -> exception = e));
        When("parse period from {}",                     (String value) -> wrap(() -> result = parser.parsePeriod(value), e -> exception = e));
        When("parse calendar from {}",                   (String value) -> wrap(() -> result = parser.parseCalendar(value), e -> exception = e));
        Then("parsed time should be equal to {}",        (Integer value) -> assertThat(result).isEqualTo(value));
        Then("parsed period should be equal to {}",      (Integer[] value) -> assertThat(result).isEqualTo(value));
        Then("parsed calendar should be equal to {}",    (Integer[][] value) -> assertThat(result).isEqualTo(value));
        Then("parsing should succeed",                   () -> assertThat(exception).isNull());
        Then("parsing should failed",                    () -> assertThat(exception).isNotNull());
        Then("parsing exception is instance of {}",      (Class<? extends Throwable> value)-> assertThat(exception).isInstanceOf(value));
        Then("parsing exception has message {}",         (String value) -> assertThat(exception).hasMessage(value));
        Then("parsing exception root is instance of {}", (Class<? extends Throwable> value) -> assertThat(exception).hasRootCauseInstanceOf(value));
        Then("parsing exception root has message {}",    (String value) ->{System.out.println(value);assertThat(exception).hasRootCauseMessage(value);});
        // @formatter:on
    }

}
