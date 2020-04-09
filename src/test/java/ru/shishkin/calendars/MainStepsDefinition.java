package ru.shishkin.calendars;

import io.cucumber.java8.En;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.assertj.core.api.Assertions.assertThat;
import static ru.shishkin.calendars.util.CommonStepsDefinition.wrap;

public class MainStepsDefinition implements En {

    private final ByteArrayOutputStream systemOutContent = new ByteArrayOutputStream();
    private final StringBuilder userInput = new StringBuilder();
    private Throwable exception;

    {
        // @formatter:off
        When("user starts program",                 () -> System.setOut(new PrintStream(systemOutContent)));
        When("user types line {string} in console", (String value) -> userInput.append(value).append(System.lineSeparator()));
        When("user press enter",                    () -> wrap(this::execute, e -> exception = e));
        Then("program finished successfully",       () -> assertThat(exception).isNull());
        Then("program should print {string}",       (String value) -> assertThat(systemOutContent.toString()).isEqualTo(value + System.lineSeparator()));
        // @formatter:on

        After(() -> System.setOut(System.out));
    }

    private void execute() {
        ByteArrayInputStream inputStream = new ByteArrayInputStream(userInput.toString().getBytes());
        System.setIn(inputStream);
        Main.main(new String[]{});
    }

}
