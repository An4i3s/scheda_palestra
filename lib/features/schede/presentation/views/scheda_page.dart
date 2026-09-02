import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
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
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        toolbarHeight: 96,
        backgroundColor: AppColors.backgroundColor,
        title: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              context.i18n.myGymSheets,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              context.i18n.manageGymSheet,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
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
          final createButton = SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.secondaryBtnColor,
                  ),
                  side: WidgetStatePropertyAll(BorderSide.none),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: context.read<SchedeBloc>()),
                      ],
                      child: const SchedaFormPage(),
                    ),
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.add, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        context.i18n.createNewGymSheet,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          return CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              createButton,
              switch (state) {
                SchedeInitial() || SchedeLoading() => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                SchedeLoaded(schede: final schede) when schede.isEmpty =>
                  const SliverFillRemaining(
                    child: Center(child: Text('Nessuna scheda. Creane una!')),
                  ),
                SchedeLoaded(schede: final schede) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.i18n.createdSheets(schede.length),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    final scheda = schede[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ).copyWith(bottom: 16),
                      child: SchedaCard(
                        scheda: scheda,
                        onEdit: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<SchedeBloc>(),
                              child: SchedaFormPage(scheda: scheda),
                            ),
                          ),
                        ),
                        onDelete: () => context.read<SchedeBloc>().add(
                          SchedaDeleted(scheda.id),
                        ),
                      ),
                    );
                  }, childCount: schede.length + 1),
                ),
                SchedeError() => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 8),
                        Text((state).message),
                        TextButton(
                          onPressed: () => context.read<SchedeBloc>().add(
                            const SchedeStarted(),
                          ),
                          child:  Text(context.i18n.tryAgain),
                        ),
                      ],
                    ),
                  ),
                ),
                _ => const SliverFillRemaining(child: SizedBox.shrink()),
              },
            ],
          );
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
