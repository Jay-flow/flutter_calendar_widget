import 'package:flutter/widgets.dart';

String? getLanguageCode(BuildContext context) =>
    Localizations.localeOf(context).languageCode;
