import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/custom_form_field.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_form_dialog.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_scheda_form.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/workout_category_container.dart';

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

  void _showExerciseDialog({int? index, ExerciseModel? esercizio}) {
    showDialog<void>(
      context: context,
      builder: (_) => ExerciseFormDialog(
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
    );
  }

  void _deleteEsercizio(int index) {
    setState(() => _esercizi.removeAt(index));
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

  void _onClose() {
    showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          backgroundColor: AppColors.containerColor,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.i18n.confirmExit,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  context.i18n.confirmExitSubtitle,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.greyTextColor,
                          ),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          context.i18n.cancel,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.primaryColor,
                          ),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          context.i18n.confirm,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isEditing ? context.i18n.editGymSheet : context.i18n.newGymSheet,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            IconButton(icon: Icon(Icons.close), onPressed: _onClose),
          ],
        ),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderContainerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        isReadOnly: false,
                        nomeController: _nomeController,
                        hintText: "ex Upper Body, Leg Day...",
                        label: context.i18n.gymSheetName,
                      ),
                      const SizedBox(height: 12),
                      CustomFormField(
                        isReadOnly: false,
                        hasValidations: false,
                        nomeController: _descrizioneController,
                        hintText: context.i18n.description,
                        label: context.i18n.description,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: WorkoutCategoryContainer(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) =>
                      setState(() => _selectedCategory = category),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.i18n.exercisesCount(_esercizi.length),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () => _showExerciseDialog(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.primaryColor,
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: Text(context.i18n.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (_esercizi.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Center(child: Text(context.i18n.noExercise)),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ExerciseSchedaForm(
                    esercizi: _esercizi,
                    onDelete: (i) => _deleteEsercizio(i),
                    onEdit: (i, e) =>
                        _showExerciseDialog(index: i, esercizio: e),
                  ),
                ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                  onPressed: _submit,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.primaryColor,
                    ),
                    side: WidgetStatePropertyAll(BorderSide.none),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        context.i18n.saveGymSheet,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
