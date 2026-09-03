// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Scheda Palestra';

  @override
  String get homeGreeting => 'Bentornato';

  @override
  String get homeMessage => 'Continua cosi!';

  @override
  String get goal => 'Obiettivo';

  @override
  String get archive => 'Archivio';

  @override
  String get weeklyPlan => 'Piano Settimanale';

  @override
  String get weeklyPlanError => 'Non è stato possibile caricare il piano settimanale.';

  @override
  String get monthlyGoal => 'Allenamenti questo mese';

  @override
  String get chooseGymSheet => 'Scegli una scheda da assegnare';

  @override
  String get noGymSheet => 'Nessuna scheda disponibile. Creane una nel tab Schede!';

  @override
  String get editGymSheet => 'Modifica scheda';

  @override
  String get newGymSheet => 'Nuova scheda';

  @override
  String get createNewGymSheet => 'Crea nuova scheda';

  @override
  String get saveGymSheet => 'Salva Scheda';

  @override
  String get myGymSheets => 'Le mie schede';

  @override
  String get noDescription => 'Nessuna descrizione';

  @override
  String get description => 'Descrizione';

  @override
  String get gymSheet => 'Schede';

  @override
  String get gymSheetName => 'Nome Scheda';

  @override
  String createdSheets(Object count) {
    return 'Schede Create ($count)';
  }

  @override
  String get deleteGymSheet => 'Elimina Scheda';

  @override
  String deleteConfirmMessage(String nome) {
    return 'Stai per eliminare \"$nome\"';
  }

  @override
  String get manageGymSheet => 'Gestisci i tuoi programmi di allenamento';

  @override
  String exercisesCount(int count) {
    return 'Esercizi ($count)';
  }

  @override
  String exercisesCount2(Object count) {
    return ' ($count) esercizi';
  }

  @override
  String get noExercise => 'Nessun esercizio aggiunto';

  @override
  String get hideExercise => 'Nascondi esercizi';

  @override
  String get showExercise => 'Mostra esercizi';

  @override
  String get rest => 'Riposo';

  @override
  String get restDay => 'Giorno di riposo';

  @override
  String get noWorkout => 'Nessun allenamento';

  @override
  String get workoutType => 'Tipo di Allenamento';

  @override
  String get workoutCompleted => '🏆 Workout Completato!';

  @override
  String completedExercisesCount(String count) {
    return ' ($count) completati';
  }

  @override
  String get viewWorkoutLog => 'Visualizza i tuoi allenamenti passati';

  @override
  String get noWorkoutLog => 'Ancora nessun workout registrato!';

  @override
  String get totalWorkoutLog => 'Allenamenti totali';

  @override
  String get ruuning => 'Corsa';

  @override
  String get ruuningDescription => 'Corsa outdoor o tapis roulant';

  @override
  String get walking => 'Camminata';

  @override
  String get walkingDescription => 'Camminata veloce o in pendenza';

  @override
  String get strenght => 'Forza';

  @override
  String get strenghtDescription => 'Allenamento di forza';

  @override
  String get bicycle => 'Bicicletta';

  @override
  String get bicycleDescription => 'Bici o cyclette';

  @override
  String get pilates => 'Pilates';

  @override
  String get pilatesDescription => 'Sessione di Pilates';

  @override
  String get swimming => 'Nuoto';

  @override
  String get swimmingDescription => 'Nuoto in mare o piscina';

  @override
  String workoutStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Serie $days giorni',
      one: 'Serie $days giorno',
      zero: 'Nessuna serie',
    );
    return '$_temp0';
  }

  @override
  String get importBackup => 'Importa backup';

  @override
  String get exportBackup => 'Esporta backup';

  @override
  String get backupTitle => 'Backup';

  @override
  String get importConfirmTitle => 'Importa backup';

  @override
  String get importConfirmMessage => 'Questa operazione sovrascriverà tutti i dati attuali con quelli del backup. L\'azione non è reversibile. Vuoi continuare?';

  @override
  String get cancel => 'Annulla';

  @override
  String get overwrite => 'Sovrascrivi';

  @override
  String get importSuccess => 'Backup importato con successo';

  @override
  String get exportSuccess => 'Backup esportato con successo';

  @override
  String importError(String error) {
    return 'Errore durante l\'import: $error';
  }

  @override
  String exportError(String error) {
    return 'Errore durante l\'export: $error';
  }

  @override
  String get settings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get italian => 'Italiano';

  @override
  String get english => 'Inglese';

  @override
  String get french => 'Francese';

  @override
  String get spanish => 'Spagnolo';

  @override
  String get add => 'Aggiungi';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Chiudi';

  @override
  String get details => 'Dettagli';

  @override
  String get tryAgain => 'Riprova';
}
