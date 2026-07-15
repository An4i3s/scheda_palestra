
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/exercises_bloc/exercises_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_form_dialog.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/workout_category_container.dart';

//Todo creare lista esercizi name con nome e tipo eservzio (target group)

class SchedaFormPage extends StatefulWidget {
  final SchedaModel? scheda;

  const SchedaFormPage({super.key, this.scheda});

  @override
  State<SchedaFormPage> createState() => _SchedaFormPageState();
}

class _SchedaFormPageState extends State<SchedaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _descrizioneController;
  late List<ExerciseModel> _esercizi;
  WorkoutCategory? _selectedCategory;

  bool get _isEditing => widget.scheda != null;
  

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.scheda?.nome ?? '');
    _descrizioneController = TextEditingController(
      text: widget.scheda?.descrizione ?? '',
    );
    _esercizi = List.from(widget.scheda?.esercizi ?? []);
    _selectedCategory = widget.scheda?.category ?? WorkoutCategory.strength;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descrizioneController.dispose();
    super.dispose();
  }

  void _addEsercizio(ExerciseModel esercizio) {
    setState(() => _esercizi.add(esercizio));
  }

  void _editEsercizio(int index, ExerciseModel esercizio) {
    setState(() => _esercizi[index] = esercizio);
  }

  void _deleteEsercizio(int index) {
    setState(() => _esercizi.removeAt(index));
  }

  void _reorderEsercizi(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _esercizi.removeAt(oldIndex);
      _esercizi.insert(newIndex, item);
    });
  }

  void _showExerciseDialog({int? index, ExerciseModel? esercizio}) {
    showDialog<void>(
      context: context,
      builder: (_) =>  BlocProvider.value(
        value: context.read<ExercisesBloc>(),
        child: ExerciseFormDialog(
          esercizio: esercizio,
          defaultCategory: _selectedCategory,
          onSubmit: (saved) {
            if (index != null) {
              _editEsercizio(index, saved);
            } else {
              _addEsercizio(saved);
            }
          },
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final scheda = SchedaModel(
      id: widget.scheda?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      descrizione: _descrizioneController.text.trim(),
      createdAt: widget.scheda?.createdAt ?? DateTime.now(),
      esercizi: _esercizi,
      category: _selectedCategory ?? WorkoutCategory.strength,
    );

    context.read<SchedeBloc>().add(SchedaSaved(scheda));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Modifica scheda' : 'Nuova scheda'),
        actions: [
          TextButton(
            onPressed: _submit,
            child: const Text('Salva'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WorkoutCategoryContainer(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) => setState(() => _selectedCategory = category),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome scheda *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descrizioneController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Descrizione',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Esercizi (${_esercizi.length})',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  FilledButton.icon(
                    onPressed: () => _showExerciseDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Aggiungi'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _esercizi.isEmpty
                  ? const Center(child: Text('Nessun esercizio aggiunto'))
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _esercizi.length,
                      onReorder: _reorderEsercizi,
                      itemBuilder: (context, index) {
                        final e = _esercizi[index];
                        return ListTile(
                          key: ValueKey(index),
                          leading: const Icon(Icons.drag_handle),
                          title: Text(e.name),
                          subtitle: Text(
                            '${e.series} serie × ${e.repetitions} rip — ${e.weight} kg',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _showExerciseDialog(
                                  index: index,
                                  esercizio: e,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                color: Theme.of(context).colorScheme.error,
                                onPressed: () => _deleteEsercizio(index),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

          ],
        ),
      ),
    );
  }
}