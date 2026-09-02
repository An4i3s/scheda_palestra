import 'package:flutter/material.dart';
import 'package:scheda_palestra/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get i18n => AppLocalizations.of(this)!;
}