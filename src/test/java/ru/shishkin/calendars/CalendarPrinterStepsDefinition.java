package ru.shishkin.calendars;

import io.cucumber.java8.En;

import static org.assertj.core.api.Assertions.assertThat;
import static ru.shishkin.calendars.util.CommonStepsDefinition.wrap;

public class CalendarPrinterStepsDefinition implements En {

    private CalendarPrinter printer;
    private String result;
    private Throwable exception;

    {
        // @formatter:off
        Given("a calendar printer",                          () -> printer = new CalendarPrinter());
        When("print time from {}",                           (Integer value) -> wrap(() -> result = printer.printTime(value), e -> exception = e));
        When("print period from {}",                         (int[] value) -> wrap(() -> result = printer.printPeriod(value), e -> exception = e));
        When("print calendar from {}",                       (int[][] value) -> wrap(() -> result = printer.printCalendar(value), e -> exception = e));
        Then("printed time should be equal to {string}",     (String value) -> assertThat(result).isEqualTo(value));
        Then("printed period should be equal to {string}",   (String value) -> assertThat(result).isEqualTo(value));
        Then("printed calendar should be equal to {string}", (String value) -> assertThat(result).isEqualTo(value));
        Then("printing should succeed",                      () -> assertThat(exception).isNull());
        Then("printing should failed",                       () -> assertThat(exception).isNotNull());
        Then("printing exception is instance of {}",         (Class<? extends Throwable> value) -> assertThat(exception).isInstanceOf(value));
        Then("printing exception has message {string}",      (String value) -> assertThat(exception).hasMessage(value));
        Then("printing exception root is instance of {}",    (Class<? extends Throwable> value) -> assertThat(exception).hasRootCauseInstanceOf(value));
        Then("printing exception root has message {string}", (String value) -> assertThat(exception).hasRootCauseMessage(value));
        // @formatter:on
    }

}
