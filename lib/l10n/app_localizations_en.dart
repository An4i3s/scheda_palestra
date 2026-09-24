// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gym Log';

  @override
  String get homeGreeting => 'Welcome back';

  @override
  String get homeMessage => 'Keep it up!';

  @override
  String get goal => 'Goal';

  @override
  String get archive => 'Archive';

  @override
  String get weeklyPlan => 'Weekly Plan';

  @override
  String get weeklyPlanError => 'Unable to load the weekly plan.';

  @override
  String get monthlyGoal => 'Workouts this month';

  @override
  String get chooseGymSheet => 'Choose a plan to assign';

  @override
  String get noGymSheet => 'No plan available. Create one in the Plans tab!';

  @override
  String get editGymSheet => 'Edit plan';

  @override
  String get newGymSheet => 'New plan';

  @override
  String get createNewGymSheet => 'Create new plan';

  @override
  String get saveGymSheet => 'Save plan';

  @override
  String get myGymSheets => 'My plans';

  @override
  String get noDescription => 'No description';

  @override
  String get description => 'Description';

  @override
  String get gymSheet => 'Plans';

  @override
  String get gymSheetName => 'Plan name';

  @override
  String createdSheets(Object count) {
    return 'Created plans ($count)';
  }

  @override
  String get deleteGymSheet => 'Delete plan';

  @override
  String deleteConfirmMessage(String nome) {
    return 'You are about to delete \"$nome\"';
  }

  @override
  String get manageGymSheet => 'Manage your workout plans';

  @override
  String exercisesCount(int count) {
    return 'Exercises ($count)';
  }

  @override
  String exercisesCount2(Object count) {
    return ' ($count) exercises';
  }

  @override
  String get noExercise => 'No exercises added';

  @override
  String get hideExercise => 'Hide exercises';

  @override
  String get showExercise => 'Show exercises';

  @override
  String get rest => 'Rest';

  @override
  String get restDay => 'Rest day';

  @override
  String get restDaySubtitle => 'Recovery is part of the training.\nYour body is growing right now.';

  @override
  String get noWorkout => 'No workout';

  @override
  String get workoutType => 'Workout type';

  @override
  String get workoutCompleted => '🏆 Workout completed!';

  @override
  String completedExercisesCount(String count) {
    return ' ($count) completed';
  }

  @override
  String get viewWorkoutLog => 'View your past workouts';

  @override
  String get noWorkoutLog => 'No workouts logged yet!';

  @override
  String get totalWorkoutLog => 'Total workouts';

  @override
  String get ruuning => 'Running';

  @override
  String get ruuningDescription => 'Outdoor or treadmill running';

  @override
  String get walking => 'Walking';

  @override
  String get walkingDescription => 'Brisk or incline walking';

  @override
  String get strenght => 'Strength';

  @override
  String get strenghtDescription => 'Strength training';

  @override
  String get bicycle => 'Cycling';

  @override
  String get bicycleDescription => 'Bike or stationary bike';

  @override
  String get pilates => 'Pilates';

  @override
  String get pilatesDescription => 'Pilates session';

  @override
  String get swimming => 'Swimming';

  @override
  String get swimmingDescription => 'Swimming in sea or pool';

  @override
  String workoutStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days-day streak 🔥',
      one: '$days-day streak 🔥',
      zero: 'No streak',
    );
    return '$_temp0';
  }

  @override
  String get importBackup => 'Import backup';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get backupTitle => 'Backup';

  @override
  String get importConfirmTitle => 'Import backup';

  @override
  String get importConfirmMessage => 'This operation will overwrite all current data with the backup data. This action cannot be undone. Do you want to continue?';

  @override
  String get cancel => 'Cancel';

  @override
  String get overwrite => 'Overwrite';

  @override
  String get importSuccess => 'Backup imported successfully';

  @override
  String get exportSuccess => 'Backup exported successfully';

  @override
  String importError(String error) {
    return 'Error during import: $error';
  }

  @override
  String exportError(String error) {
    return 'Error during export: $error';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get italian => 'Italian';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String get spanish => 'Spanish';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get details => 'Details';

  @override
  String get tryAgain => 'Try again';

  @override
  String get serie => 'Sets';

  @override
  String get reps => 'Reps';

  @override
  String get weight => 'Weight';

  @override
  String get time => 'Time';

  @override
  String get km => 'Km';

  @override
  String get elevation => 'Elevation';

  @override
  String get timer => 'Timer';

  @override
  String get pause => 'Pause';

  @override
  String get restart => 'Restart';

  @override
  String get resume => 'Resume';

  @override
  String get start => 'Start';

  @override
  String get reinitialize => 'Reset';
}
