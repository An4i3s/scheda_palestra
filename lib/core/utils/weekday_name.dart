
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> getWeekdayNames(BuildContext context, {bool short = false}) {
  final locale = Localizations.localeOf(context).toString();
  final symbols = DateFormat.EEEE(locale).dateSymbols; // full names
  
  return  symbols.SHORTWEEKDAYS;
}

List<String> getWeekdayNamesMondayFirst(BuildContext context, {bool short = false}) {
  final full = getWeekdayNames(context, short: short);
  return [...full.sublist(1), full[0]];
}