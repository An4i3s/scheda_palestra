// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Registro de Gimnasio';

  @override
  String get homeGreeting => 'Bienvenido de nuevo';

  @override
  String get homeMessage => '¡Sigue así!';

  @override
  String get goal => 'Objetivo';

  @override
  String get archive => 'Archivo';

  @override
  String get weeklyPlan => 'Plan Semanal';

  @override
  String get weeklyPlanError => 'No se pudo cargar el plan semanal.';

  @override
  String get monthlyGoal => 'Entrenamientos este mes';

  @override
  String get chooseGymSheet => 'Elige una rutina para asignar';

  @override
  String get noGymSheet => 'No hay rutinas disponibles. ¡Crea una en la pestaña Rutinas!';

  @override
  String get editGymSheet => 'Editar rutina';

  @override
  String get newGymSheet => 'Nueva rutina';

  @override
  String get createNewGymSheet => 'Crear nueva rutina';

  @override
  String get saveGymSheet => 'Guardar rutina';

  @override
  String get myGymSheets => 'Mis rutinas';

  @override
  String get noDescription => 'Sin descripción';

  @override
  String get description => 'Descripción';

  @override
  String get gymSheet => 'Rutinas';

  @override
  String get gymSheetName => 'Nombre de la rutina';

  @override
  String createdSheets(Object count) {
    return 'Rutinas creadas ($count)';
  }

  @override
  String get deleteGymSheet => 'Eliminar rutina';

  @override
  String deleteConfirmMessage(String nome) {
    return 'Estás a punto de eliminar \"$nome\"';
  }

  @override
  String get manageGymSheet => 'Gestiona tus programas de entrenamiento';

  @override
  String exercisesCount(int count) {
    return 'Ejercicios ($count)';
  }

  @override
  String exercisesCount2(Object count) {
    return ' ($count) ejercicios';
  }

  @override
  String get noExercise => 'No se ha añadido ningún ejercicio';

  @override
  String get hideExercise => 'Ocultar ejercicios';

  @override
  String get showExercise => 'Mostrar ejercicios';

  @override
  String get rest => 'Descanso';

  @override
  String get restDay => 'Día de descanso';

  @override
  String get noWorkout => 'Sin entrenamiento';

  @override
  String get workoutType => 'Tipo de entrenamiento';

  @override
  String get workoutCompleted => '🏆 ¡Entrenamiento completado!';

  @override
  String completedExercisesCount(String count) {
    return ' ($count) completados';
  }

  @override
  String get viewWorkoutLog => 'Consulta tus entrenamientos pasados';

  @override
  String get noWorkoutLog => '¡Aún no hay entrenamientos registrados!';

  @override
  String get totalWorkoutLog => 'Entrenamientos totales';

  @override
  String get ruuning => 'Correr';

  @override
  String get ruuningDescription => 'Correr al aire libre o en cinta';

  @override
  String get walking => 'Caminata';

  @override
  String get walkingDescription => 'Caminata rápida o en pendiente';

  @override
  String get strenght => 'Fuerza';

  @override
  String get strenghtDescription => 'Entrenamiento de fuerza';

  @override
  String get bicycle => 'Bicicleta';

  @override
  String get bicycleDescription => 'Bicicleta o bicicleta estática';

  @override
  String get pilates => 'Pilates';

  @override
  String get pilatesDescription => 'Sesión de Pilates';

  @override
  String get swimming => 'Natación';

  @override
  String get swimmingDescription => 'Natación en mar o piscina';

  @override
  String workoutStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Racha de $days días 🔥',
      one: 'Racha de $days día 🔥',
      zero: 'Sin racha',
    );
    return '$_temp0';
  }

  @override
  String get importBackup => 'Importar copia de seguridad';

  @override
  String get exportBackup => 'Exportar copia de seguridad';

  @override
  String get backupTitle => 'Copia de seguridad';

  @override
  String get importConfirmTitle => 'Importar copia de seguridad';

  @override
  String get importConfirmMessage => 'Esta operación sobrescribirá todos los datos actuales con los de la copia de seguridad. Esta acción no se puede deshacer. ¿Quieres continuar?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get overwrite => 'Sobrescribir';

  @override
  String get importSuccess => 'Copia de seguridad importada correctamente';

  @override
  String get exportSuccess => 'Copia de seguridad exportada correctamente';

  @override
  String importError(String error) {
    return 'Error durante la importación: $error';
  }

  @override
  String exportError(String error) {
    return 'Error durante la exportación: $error';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get italian => 'Italiano';

  @override
  String get english => 'Inglés';

  @override
  String get french => 'Francés';

  @override
  String get spanish => 'Español';

  @override
  String get add => 'Añadir';

  @override
  String get delete => 'Eliminar';

  @override
  String get close => 'Cerrar';

  @override
  String get details => 'Detalles';

  @override
  String get tryAgain => 'Reintentar';
}
