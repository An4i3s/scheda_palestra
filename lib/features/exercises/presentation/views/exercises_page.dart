import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_bloc.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_events.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_state.dart';
import 'package:scheda_palestra/features/exercises/presentation/views/exercise_type_form_dialog.dart';
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
      builder: (_) => ExerciseTypeFormDialog(
        exerciseType: esercizio,
        // onSubmit: (saved) {
        //   if (index != null) {
        //     _editEsercizio(index, saved);
        //   } else {
        //     _addEsercizio(saved);
        //   }
        // },
      ),
    );
  }


  // void _addEsercizio(ExerciseTypeModel esercizio) {
  //   setState(() => _esercizi.add(esercizio));
  // }


  //   void _editEsercizio(int index, ExerciseTypeModel esercizio) {
  //   setState(() => _esercizi[index] = esercizio);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Esercizi')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExerciseDialog(),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ExercisesBloc, ExercisesState>(
        listener: (context, state) {
          // Listen for state changes
               if (state is ExercisesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // Build your UI based on the state
          return switch (state) {
            ExercisesInitial() || ExercisesLoading() => const Center(child: CircularProgressIndicator()),
            ExercisesLoaded(exercises: final exercises) when exercises.isEmpty =>
              const Center(child: Text('Nessun esercizio. Creane uno!')),
            ExercisesLoaded(exercises: final exercises) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: exercises.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(exercises[index].name),
                subtitle: Text('Series: ${exercises[index].series}, Reps: ${exercises[index].repetitions}'),
              ),
            ),
            ExercisesError() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 8),
                  Text((state).message),
                  TextButton(
                    onPressed: () =>
                        context.read<ExercisesBloc>().add(const ExercisesStarted()),
                    child: const Text('Riprova'),
                  ),
                ],
              ),
             _ => const SizedBox.shrink(),
          };
        },

      ),
    );
  }
}