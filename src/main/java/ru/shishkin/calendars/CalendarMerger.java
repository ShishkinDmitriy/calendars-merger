package ru.shishkin.calendars;

import java.util.ArrayList;

import static ru.shishkin.calendars.CalendarConstants.HOURS_IN_DAY;
import static ru.shishkin.calendars.CalendarConstants.MINUTES_IN_HOUR;

public class CalendarMerger {

    public static final int END = HOURS_IN_DAY * MINUTES_IN_HOUR;

    public int[][] merge(int[][] calendar1, int[] bounds1, int[][] calendar2, int[] bounds2, int duration) {
        var calendarFinal1 = mergeBounds(calendar1, bounds1);
        var calendarFinal2 = mergeBounds(calendar2, bounds2);
        var result = new ArrayList<int[]>();
        for (int i = 1; i < calendarFinal1.length; i++) {
            var period1 = new int[]{calendarFinal1[i - 1][1], calendarFinal1[i][0]};
            for (int j = 1; j < calendarFinal1.length; j++) {
                var period2 = new int[]{calendarFinal2[j - 1][1], calendarFinal2[j][0]};
                if (!isBefore(period1, period2) || !isAfter(period1, period2)) {
                    var start = Math.max(period1[0], period2[0]);
                    var end = Math.min(period1[1], period2[1]);
                    if (end - start >= duration) {
                        result.add(new int[]{start, end});
                    }
                }
            }
        }
        return result.toArray(int[][]::new);
    }

    protected int[][] mergeBounds(int[][] calendar, int[] bounds) {
        var extraStartPeriod = new int[]{0, bounds[0]};
        var extraEndPeriod = new int[]{bounds[1], END};
        var result = new ArrayList<int[]>();
        result.add(extraStartPeriod);
        result.add(extraEndPeriod);
        for (int[] period : calendar) {
            if (isAfter(period, extraStartPeriod) && isBefore(period, extraEndPeriod)) {
                result.add(result.size() - 1, period);
            } else {
                if (isCrossRight(period, extraStartPeriod)) {
                    extraStartPeriod[1] = period[1];
                }
                if (isCrossLeft(period, extraStartPeriod)) {
                    extraEndPeriod[0] = period[0];
                    break;
                }
            }
        }
        return result.toArray(int[][]::new);
    }

    private boolean isCrossLeft(int[] value, int[] sample) {
        return value[0] < sample[0] && value[1] >= sample[0] && value[1] <= sample[1];
    }

    private boolean isCrossRight(int[] value, int[] sample) {
        return value[0] >= sample[0] && value[0] <= sample[1] && value[1] > sample[1];
    }

    private boolean isBefore(int[] value, int[] sample) {
        return value[1] < sample[0];
    }

    private boolean isAfter(int[] value, int[] sample) {
        return value[0] > sample[1];
    }

}
