package ru.shishkin.calendars;

import io.cucumber.java8.En;

import static org.assertj.core.api.Assertions.assertThat;

public class CalendarMergerStepsDefinition implements En {

    private CalendarMerger merger;
    private int[][] result;
    private Throwable exception;

    {
        // @formatter:off
        Given("a calendar merger",                       () -> merger = new CalendarMerger());
        When("merge {} with {} with {} with {} with {}", this::merge);
        When("merge bounds {} with {}",                  this::mergeBounds);
        Then("merging should succeed",                   () -> assertThat(exception).isNull());
        Then("merged calendar should be equal to {}",    (int[][] value) -> assertThat(result).isEqualTo(value));
        // @formatter:on
    }

    private void merge(int[][] calendar1, int[] bounds1, int[][] calendar2, int[] bounds2, int duration) {
        result = merger.merge(calendar1, bounds1, calendar2, bounds2, duration);
    }

    protected void mergeBounds(int[][] calendar, int[] bounds) {
        result = merger.mergeBounds(calendar, bounds);
    }

}
