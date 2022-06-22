import 'package:flutter_calendar_widget/src/classes/calender_builder.dart';
import 'package:flutter_calendar_widget/src/models/calender_style.dart';
import 'package:flutter_calendar_widget/src/models/calender_text_style.dart';

class DefaultCalenderBuilder extends CalenderBuilder {
  const DefaultCalenderBuilder({
    required CalenderTextStyle textStyle,
    required CalenderStyle style,
  }) : super(
          textStyle: textStyle,
          style: style,
        );
}
