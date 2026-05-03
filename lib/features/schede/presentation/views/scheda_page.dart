import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';
import 'package:scheda_palestra/features/schede/presentation/views/scheda_form_page.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/scheda_card.dart';

class SchedePage extends StatefulWidget {
  const SchedePage({super.key});

  @override
  State<SchedePage> createState() => _SchedePageState();
}

class _SchedePageState extends State<SchedePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Le mie schede')),
            backgroundColor: AppColors.backgroundColor,

      floatingActionButton: FloatingActionButton(
        heroTag: 'scheda_form',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: context.read<SchedeBloc>()),
                BlocProvider.value(value: context.read<ExerciseTypeBloc>()),
              ],
              child: const SchedaFormPage(),
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<SchedeBloc, SchedaState>(
        listener: (context, state) {
          if (state is SchedeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return switch (state) {
            SchedeInitial() ||
            SchedeLoading() => const Center(child: CircularProgressIndicator()),
            SchedeLoaded(schede: final schede) when schede.isEmpty =>
              const Center(child: Text('Nessuna scheda. Creane una!')),
            SchedeLoaded(schede: final schede) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: schede.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SchedaCard(
                  scheda: schede[index],
                  onEdit: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: context.read<SchedeBloc>()),
                          BlocProvider.value(value: context.read<ExerciseTypeBloc>()),
                        ],
                        child: SchedaFormPage(scheda: schede[index]),
                      ),
                    ),
                  ),
                  onDelete: () => context.read<SchedeBloc>().add(
                    SchedaDeleted(schede[index].id),
                  ),
                ),
              ),
            ),
            SchedeError() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 8),
                  Text((state).message),
                  TextButton(
                    onPressed: () =>
                        context.read<SchedeBloc>().add(const SchedeStarted()),
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

  //   void _showFormDialog(BuildContext context, SchedaModel? scheda) {
  //   final bloc = context.read<SchedeBloc>();
  //   showDialog<void>(
  //     context: context,
  //     builder: (_) => SchedaFormDialog(
  //       scheda: scheda,
  //       onSubmit: (saved) => bloc.add(SchedaSaved(saved)),
  //     ),
  //   );
  // }
}
