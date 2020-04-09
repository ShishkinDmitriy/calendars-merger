package ru.shishkin.calendars;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        try (var scanner = new Scanner(System.in)) {
            var parser = new CalendarParser();
            var merger = new CalendarMerger();
            var printer = new CalendarPrinter();
            var calendar1 = parser.parseCalendar(scanner.nextLine());
            var bounds1 = parser.parsePeriod(scanner.nextLine());
            var calendar2 = parser.parseCalendar(scanner.nextLine());
            var bounds2 = parser.parsePeriod(scanner.nextLine());
            var duration = Integer.parseInt(scanner.nextLine());
            var result = merger.merge(calendar1, bounds1, calendar2, bounds2, duration);
            System.out.print(printer.printCalendar(result));
            System.out.println();
        }
    }

}
