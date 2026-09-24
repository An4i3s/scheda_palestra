// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Carnet de Salle';

  @override
  String get homeGreeting => 'Bon retour';

  @override
  String get homeMessage => 'Continue comme ça !';

  @override
  String get goal => 'Objectif';

  @override
  String get archive => 'Archives';

  @override
  String get weeklyPlan => 'Programme Hebdomadaire';

  @override
  String get weeklyPlanError => 'Impossible de charger le programme hebdomadaire.';

  @override
  String get monthlyGoal => 'Entraînements ce mois-ci';

  @override
  String get chooseGymSheet => 'Choisis une fiche à assigner';

  @override
  String get noGymSheet => 'Aucune fiche disponible. Crées-en une dans l\'onglet Fiches !';

  @override
  String get editGymSheet => 'Modifier la fiche';

  @override
  String get newGymSheet => 'Nouvelle fiche';

  @override
  String get createNewGymSheet => 'Créer une nouvelle fiche';

  @override
  String get saveGymSheet => 'Enregistrer la fiche';

  @override
  String get myGymSheets => 'Mes fiches';

  @override
  String get noDescription => 'Aucune description';

  @override
  String get description => 'Description';

  @override
  String get gymSheet => 'Fiches';

  @override
  String get gymSheetName => 'Nom de la fiche';

  @override
  String createdSheets(Object count) {
    return 'Fiches créées ($count)';
  }

  @override
  String get deleteGymSheet => 'Supprimer la fiche';

  @override
  String deleteConfirmMessage(String nome) {
    return 'Tu es sur le point de supprimer \"$nome\"';
  }

  @override
  String get manageGymSheet => 'Gère tes programmes d\'entraînement';

  @override
  String exercisesCount(int count) {
    return 'Exercices ($count)';
  }

  @override
  String exercisesCount2(Object count) {
    return ' ($count) exercices';
  }

  @override
  String get noExercise => 'Aucun exercice ajouté';

  @override
  String get hideExercise => 'Masquer les exercices';

  @override
  String get showExercise => 'Afficher les exercices';

  @override
  String get rest => 'Repos';

  @override
  String get restDay => 'Jour de repos';

  @override
  String get restDaySubtitle => 'La récupération fait partie de l\'entraînement.\nTon corps est en train de progresser, là, maintenant.';

  @override
  String get noWorkout => 'Aucun entraînement';

  @override
  String get workoutType => 'Type d\'entraînement';

  @override
  String get workoutCompleted => '🏆 Entraînement terminé !';

  @override
  String completedExercisesCount(String count) {
    return ' ($count) terminés';
  }

  @override
  String get viewWorkoutLog => 'Consulte tes entraînements passés';

  @override
  String get noWorkoutLog => 'Aucun entraînement enregistré pour le moment !';

  @override
  String get totalWorkoutLog => 'Entraînements au total';

  @override
  String get ruuning => 'Course';

  @override
  String get ruuningDescription => 'Course en extérieur ou sur tapis';

  @override
  String get walking => 'Marche';

  @override
  String get walkingDescription => 'Marche rapide ou en côte';

  @override
  String get strenght => 'Musculation';

  @override
  String get strenghtDescription => 'Entraînement de musculation';

  @override
  String get bicycle => 'Vélo';

  @override
  String get bicycleDescription => 'Vélo ou vélo d\'appartement';

  @override
  String get pilates => 'Pilates';

  @override
  String get pilatesDescription => 'Séance de Pilates';

  @override
  String get swimming => 'Natation';

  @override
  String get swimmingDescription => 'Natation en mer ou en piscine';

  @override
  String workoutStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Série de $days jours 🔥',
      one: 'Série de $days jour 🔥',
      zero: 'Aucune série',
    );
    return '$_temp0';
  }

  @override
  String get importBackup => 'Importer la sauvegarde';

  @override
  String get exportBackup => 'Exporter la sauvegarde';

  @override
  String get backupTitle => 'Sauvegarde';

  @override
  String get importConfirmTitle => 'Importer la sauvegarde';

  @override
  String get importConfirmMessage => 'Cette opération remplacera toutes les données actuelles par celles de la sauvegarde. Cette action est irréversible. Veux-tu continuer ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get overwrite => 'Remplacer';

  @override
  String get importSuccess => 'Sauvegarde importée avec succès';

  @override
  String get exportSuccess => 'Sauvegarde exportée avec succès';

  @override
  String importError(String error) {
    return 'Erreur lors de l\'import : $error';
  }

  @override
  String exportError(String error) {
    return 'Erreur lors de l\'export : $error';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get italian => 'Italien';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get spanish => 'Espagnol';

  @override
  String get add => 'Ajouter';

  @override
  String get delete => 'Supprimer';

  @override
  String get close => 'Fermer';

  @override
  String get details => 'Détails';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get serie => 'Séries';

  @override
  String get reps => 'Rép.';

  @override
  String get weight => 'Poids';

  @override
  String get time => 'Temps';

  @override
  String get km => 'Km';

  @override
  String get elevation => 'Dénivelé';

  @override
  String get timer => 'Minuteur';

  @override
  String get pause => 'Pause';

  @override
  String get restart => 'Redémarrer';

  @override
  String get resume => 'Reprendre';

  @override
  String get start => 'Démarrer';

  @override
  String get reinitialize => 'Réinitialiser';
}
