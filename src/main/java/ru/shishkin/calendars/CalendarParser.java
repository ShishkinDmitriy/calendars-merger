package ru.shishkin.calendars;

import java.util.ArrayList;
import java.util.regex.Pattern;

import static ru.shishkin.calendars.CalendarConstants.*;

public class CalendarParser {

    public static final Pattern PATTERN = Pattern.compile("(\\[[^\\]]+\\])");

    public int[][] parseCalendar(String value) {
        try {
            assert value != null && !value.isBlank() : "Wrong calendar value, it can't be null or blank";
            var clear = value.trim();
            assert clear.startsWith(ARRAY_PREFIX) && clear.endsWith(ARRAY_SUFFIX) : "Wrong calendar format: " + value;
            clear = clear.substring(1, clear.length() - 1);
            if (clear.isBlank()) {
                return new int[][]{};
            }
            var result = new ArrayList<int[]>();
            var matcher = PATTERN.matcher(clear);
            while (matcher.find()) {
                result.add(parsePeriod(matcher.group(1)));
            }
            return result.toArray(int[][]::new);
        } catch (Throwable e) {
            throw new CalendarParser.Exception("Failed to parse calendar: " + printString(value), e);
        }
    }

    public int[] parsePeriod(String value) {
        try {
            assert value != null && !value.isBlank() : "Wrong period value, it can't be null or blank";
            var clear = value.trim();
            assert clear.startsWith(ARRAY_PREFIX) && clear.endsWith(ARRAY_SUFFIX) : "Wrong period format: " + value;
            clear = clear.substring(1, clear.length() - 1);
            var period = clear.split(ARRAY_DELIMITER);
            assert period.length == 2 : "Wrong period delimiter: " + value;
            var start = parseTime(period[0]);
            var end = parseTime(period[1]);
            assert start != end : "Wrong period duration, start time can't be equal the end time: " + value;
            assert start < end : "Wrong period duration, start time can't be after the end time: " + value;
            return new int[]{start, end};
        } catch (Throwable e) {
            throw new CalendarParser.Exception("Failed to parse period: " + printString(value), e);
        }
    }

    /**
     * Parse string representation of time into a number of minutes from 00:00
     * <p>
     * It should parse strings like 00:00 up to 23:59
     *
     * @param value the string of time
     * @return a number of minutes from 00:00
     * @throws CalendarParser.Exception if value has wrong value, cause exception should contain a reason
     */
    public int parseTime(String value) {
        try {
            assert value != null && !value.isBlank() : "Wrong time value, it can't be null or blank";
            var clear = value.trim();
            assert (clear.startsWith(COMMA_SINGLE) && clear.endsWith(COMMA_SINGLE)) ||
                    (clear.startsWith(COMMA_DOUBLE) && clear.endsWith(COMMA_DOUBLE)) : "Wrong period commas: " + printString(value);
            clear = clear.substring(1, clear.length() - 1);
            var time = clear.split(TIME_DELIMITER);
            assert time.length == 2 : "Wrong time delimiter: " + value;
            var hours = Integer.parseInt(time[0].trim());
            var minutes = Integer.parseInt(time[1].trim());
            assert hours >= 0 && hours <= HOURS_IN_DAY : "Wrong time hour value: " + hours;
            assert minutes >= 0 && minutes < MINUTES_IN_HOUR : "Wrong time minutes value: " + minutes;
            return hours * MINUTES_IN_HOUR + minutes;
        } catch (Throwable e) {
            throw new CalendarParser.Exception("Failed to parse time: " + printString(value), e);
        }
    }

    private String printString(String value) {
        if (value == null) {
            return "null";
        } else {
            return "\"" + value + "\"";
        }
    }

    static class Exception extends RuntimeException {

        public Exception(String message, Throwable cause) {
            super(message, cause);
        }

    }

}
