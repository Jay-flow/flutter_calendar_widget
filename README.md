# 📅 flutter_calendar_widget

![GitHub](https://img.shields.io/github/license/dooboolab/flutter_calendar_widget)

The flutter_calendar_widget is a flexible and freely changeable calendar of widgets.

Not only can you change the style, but you can also change the widget in the calendar, so you can customize it freely if you want.

## Selection Mode

Depending on the selection mode, you can specify the following three selection methods.

### 1. `CalendarSelectionMode.single` for selecting one date.

![sigle_demo](./doc/single_demo.gif)

#### Example

```dart
FlutterCalendar(
    selectionMode: CalendarSelectionMode.single,
    onDayPressed: (DateTime date) {
        print(date);
    }
)
```

### 2. `CalendarSelectionMode.multiple` for selection of multiple dates.

![multiple_demo](./doc/multiple_demo.gif)

## Caveat

The project is currently under development and has not been released.

## Preview
