import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Gym Log'**
  String get appTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get homeGreeting;

  /// No description provided for @homeMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep it up!'**
  String get homeMessage;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @weeklyPlan.
  ///
  /// In en, this message translates to:
  /// **'Weekly Plan'**
  String get weeklyPlan;

  /// No description provided for @weeklyPlanError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the weekly plan.'**
  String get weeklyPlanError;

  /// No description provided for @monthlyGoal.
  ///
  /// In en, this message translates to:
  /// **'Workouts this month'**
  String get monthlyGoal;

  /// No description provided for @chooseGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Choose a plan to assign'**
  String get chooseGymSheet;

  /// No description provided for @noGymSheet.
  ///
  /// In en, this message translates to:
  /// **'No plan available. Create one in the Plans tab!'**
  String get noGymSheet;

  /// No description provided for @editGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Edit plan'**
  String get editGymSheet;

  /// No description provided for @newGymSheet.
  ///
  /// In en, this message translates to:
  /// **'New plan'**
  String get newGymSheet;

  /// No description provided for @createNewGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Create new plan'**
  String get createNewGymSheet;

  /// No description provided for @saveGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Save plan'**
  String get saveGymSheet;

  /// No description provided for @myGymSheets.
  ///
  /// In en, this message translates to:
  /// **'My plans'**
  String get myGymSheets;

  /// No description provided for @confirmExit.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to leave the page?'**
  String get confirmExit;

  /// No description provided for @confirmExitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If you close this screen, you will lose all your data'**
  String get confirmExitSubtitle;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @gymSheet.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get gymSheet;

  /// No description provided for @gymSheetName.
  ///
  /// In en, this message translates to:
  /// **'Plan name'**
  String get gymSheetName;

  /// No description provided for @createdSheets.
  ///
  /// In en, this message translates to:
  /// **'Created plans ({count})'**
  String createdSheets(Object count);

  /// No description provided for @deleteGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Delete plan'**
  String get deleteGymSheet;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You are about to delete \"{nome}\"'**
  String deleteConfirmMessage(String nome);

  /// No description provided for @manageGymSheet.
  ///
  /// In en, this message translates to:
  /// **'Manage your workout plans'**
  String get manageGymSheet;

  /// No description provided for @exercisesCount.
  ///
  /// In en, this message translates to:
  /// **'Exercises ({count})'**
  String exercisesCount(int count);

  /// No description provided for @exercisesCount2.
  ///
  /// In en, this message translates to:
  /// **' ({count}) exercises'**
  String exercisesCount2(Object count);

  /// No description provided for @noExercise.
  ///
  /// In en, this message translates to:
  /// **'No exercises added'**
  String get noExercise;

  /// No description provided for @hideExercise.
  ///
  /// In en, this message translates to:
  /// **'Hide exercises'**
  String get hideExercise;

  /// No description provided for @showExercise.
  ///
  /// In en, this message translates to:
  /// **'Show exercises'**
  String get showExercise;

  /// No description provided for @rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get rest;

  /// No description provided for @restDay.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get restDay;

  /// No description provided for @restDaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery is part of the training.\nYour body is growing right now.'**
  String get restDaySubtitle;

  /// No description provided for @noWorkout.
  ///
  /// In en, this message translates to:
  /// **'No workout'**
  String get noWorkout;

  /// No description provided for @workoutType.
  ///
  /// In en, this message translates to:
  /// **'Workout type'**
  String get workoutType;

  /// No description provided for @workoutCompleted.
  ///
  /// In en, this message translates to:
  /// **'🏆 Workout completed!'**
  String get workoutCompleted;

  /// No description provided for @completedExercisesCount.
  ///
  /// In en, this message translates to:
  /// **' ({count}) completed'**
  String completedExercisesCount(String count);

  /// No description provided for @viewWorkoutLog.
  ///
  /// In en, this message translates to:
  /// **'View your past workouts'**
  String get viewWorkoutLog;

  /// No description provided for @noWorkoutLog.
  ///
  /// In en, this message translates to:
  /// **'No workouts logged yet!'**
  String get noWorkoutLog;

  /// No description provided for @totalWorkoutLog.
  ///
  /// In en, this message translates to:
  /// **'Total workouts'**
  String get totalWorkoutLog;

  /// No description provided for @ruuning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get ruuning;

  /// No description provided for @ruuningDescription.
  ///
  /// In en, this message translates to:
  /// **'Outdoor or treadmill running'**
  String get ruuningDescription;

  /// No description provided for @walking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get walking;

  /// No description provided for @walkingDescription.
  ///
  /// In en, this message translates to:
  /// **'Brisk or incline walking'**
  String get walkingDescription;

  /// No description provided for @strenght.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get strenght;

  /// No description provided for @strenghtDescription.
  ///
  /// In en, this message translates to:
  /// **'Strength training'**
  String get strenghtDescription;

  /// No description provided for @bicycle.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get bicycle;

  /// No description provided for @bicycleDescription.
  ///
  /// In en, this message translates to:
  /// **'Bike or stationary bike'**
  String get bicycleDescription;

  /// No description provided for @pilates.
  ///
  /// In en, this message translates to:
  /// **'Pilates'**
  String get pilates;

  /// No description provided for @pilatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Pilates session'**
  String get pilatesDescription;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get swimming;

  /// No description provided for @swimmingDescription.
  ///
  /// In en, this message translates to:
  /// **'Swimming in sea or pool'**
  String get swimmingDescription;

  /// No description provided for @workoutStreak.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{No streak} one{{days}-day streak 🔥} other{{days}-day streak 🔥}}'**
  String workoutStreak(int days);

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackup;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackup;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupTitle;

  /// No description provided for @importConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importConfirmTitle;

  /// No description provided for @importConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This operation will overwrite all current data with the backup data. This action cannot be undone. Do you want to continue?'**
  String get importConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @overwrite.
  ///
  /// In en, this message translates to:
  /// **'Overwrite'**
  String get overwrite;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup imported successfully'**
  String get importSuccess;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup exported successfully'**
  String get exportSuccess;

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Error during import: {error}'**
  String importError(String error);

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Error during export: {error}'**
  String exportError(String error);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italian;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @serie.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get serie;

  /// No description provided for @reps.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get reps;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get km;

  /// No description provided for @elevation.
  ///
  /// In en, this message translates to:
  /// **'Elevation'**
  String get elevation;

  /// No description provided for @timer.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timer;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @reinitialize.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reinitialize;

  /// No description provided for @exerciseName.
  ///
  /// In en, this message translates to:
  /// **'Exercise name'**
  String get exerciseName;

  /// No description provided for @editExercise.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get editExercise;

  /// No description provided for @newExercise.
  ///
  /// In en, this message translates to:
  /// **'New exercise'**
  String get newExercise;

  /// No description provided for @hintExercise.
  ///
  /// In en, this message translates to:
  /// **'e.g. Bench Press'**
  String get hintExercise;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
