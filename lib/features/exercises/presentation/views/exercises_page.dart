import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_bloc.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_events.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_state.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_bloc.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_events.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_state.dart';
import 'package:scheda_palestra/features/exercises/presentation/views/exercise_type_form_dialog.dart';
import 'package:scheda_palestra/features/exercises/presentation/widgets/exercise_types_card.dart';
import 'package:scheda_palestra/features/schede/presentation/views/exercise_form_dialog.dart';

class ExercisesPage extends StatefulWidget{
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  ExerciseTypeModel? _eserciseType;

    void _showExerciseDialog({int? index, ExerciseTypeModel? esercizio}) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ExerciseTypeBloc>(),
        child: ExerciseTypeFormDialog(
          exerciseType: esercizio,
          // onSubmit: (saved) {
          //   if (index != null) {
          //     _editEsercizio(index, saved);
          //   } else {
          //     _addEsercizio(saved);
          //   }
          // },
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Esercizi')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExerciseDialog(),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ExerciseTypeBloc, ExercisesTypeState>(
        listener: (context, state) {
          // Listen for state changes
               if (state is ExercisesTypeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // Build your UI based on the state
          return switch (state) {
            ExercisesTypeInitial() || ExercisesTypeLoading() => const Center(child: CircularProgressIndicator()),
            ExercisesTypeLoaded(exercises: final exercises) when exercises.isEmpty =>
              const Center(child: Text('Nessun esercizio. Creane uno!')),
            ExercisesTypeLoaded(exercises: final exercises) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: exercises.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ExerciseTypesCard(exerciseType: exercises[index]),
              ),
            ),
            ExercisesTypeError(:final message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 8),
                  Text(message),
                  TextButton(
                    onPressed: () =>
                        context.read<ExerciseTypeBloc>().add(const ExerciseTypeStarted()),
                    child: const Text('Riprova'),
                  ),
                ],
              ),
            ),
            _ => const SizedBox.shrink(),
          };
        },

      ),
    );
  }
}