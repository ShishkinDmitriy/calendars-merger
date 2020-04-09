package ru.shishkin.calendars.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java8.En;

import java.util.function.Consumer;

public class CommonStepsDefinition implements En {

    public static final String NULL = "<NULL>";

    {
        ObjectMapper objectMapper = new ObjectMapper();
        DefaultParameterTransformer((value, type) -> {
            if (NULL.equals(value)) {
                return null;
            }
            return objectMapper.readValue(value, objectMapper.constructType(type));
        });
        DefaultDataTableCellTransformer((value, type) -> objectMapper.convertValue(value, objectMapper.constructType(type)));
        DefaultDataTableEntryTransformer((value, type) -> objectMapper.convertValue(value, objectMapper.constructType(type)));
    }

    public static void wrap(Runnable run, Consumer<Throwable> exceptionHandler) {
        try {
            run.run();
        } catch (Throwable e) {
            exceptionHandler.accept(e);
        }
    }

}
