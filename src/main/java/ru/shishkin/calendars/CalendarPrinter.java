package ru.shishkin.calendars;

import java.util.Arrays;
import java.util.stream.Collectors;

import static ru.shishkin.calendars.CalendarConstants.*;

public class CalendarPrinter {

    public String printCalendar(int[][] value) {
        try {
            assert value != null : "Wrong calendar value, it can't be null";
            return Arrays.stream(value)
                    .map(this::printPeriod)
                    .collect(Collectors.joining(ARRAY_DELIMITER + " ", ARRAY_PREFIX, ARRAY_SUFFIX));
        } catch (Throwable e) {
            throw new CalendarPrinter.Exception("Failed to print calendar: " + Arrays.toString(value), e);
        }
    }

    protected String printPeriod(int[] value) {
        try {
            assert value != null : "Wrong period value, it can't be null";
            assert value.length == 2 : "Wrong period, should contain start and end times: " + Arrays.toString(value);
            var start = value[0];
            var end = value[1];
            assert start != end : "Wrong period duration, start time can't be equal the end time: " + Arrays.toString(value);
            assert start < end : "Wrong period duration, start time can't be after the end time: " + Arrays.toString(value);
            return ARRAY_PREFIX + printTime(start) + ARRAY_DELIMITER + " " + printTime(end) + ARRAY_SUFFIX;
        } catch (Throwable e) {
            throw new CalendarPrinter.Exception("Failed to print period: " + Arrays.toString(value), e);
        }
    }

    protected String printTime(int value) {
        try {
            assert value >= 0 && value <= MINUTES_IN_HOUR * HOURS_IN_DAY : "Wrong time value, it should be in [0, 1440]: " + value;
            var hours = value / MINUTES_IN_HOUR;
            var minutes = value % MINUTES_IN_HOUR;
            return String.format("'%02d:%02d'", hours, minutes);
        } catch (Throwable e) {
            throw new CalendarPrinter.Exception("Failed to print time: " + value, e);
        }
    }

    static class Exception extends RuntimeException {

        public Exception(String message, Throwable cause) {
            super(message, cause);
        }

    }

}
