import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';

// ─── Mocks ─────────────────────────────────────────────────────────────────
// Il BLoC accetta typedef Function — usiamo classi callable mockabili.
class MockGetSchede extends Mock {
  Future<Either<Failure, List<SchedaModel>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, [])) as Future<Either<Failure, List<SchedaModel>>>);
}

class MockSaveScheda extends Mock {
  Future<Either<Failure, SchedaModel>> call(SchedaModel scheda) =>
      (super.noSuchMethod(Invocation.method(#call, [scheda])) as Future<Either<Failure, SchedaModel>>);
}

class MockDeleteScheda extends Mock {
  Future<Either<Failure, void>> call(String id) =>
      (super.noSuchMethod(Invocation.method(#call, [id])) as Future<Either<Failure, void>>);
}

// ─── Fixtures ──────────────────────────────────────────────────────────────
final tScheda = SchedaModel(
  id: '1',
  nome: 'Full Body A',
  descrizione: 'Scheda per forza e resistenza',
  esercizi: [
    ExerciseModel(
      name: 'Squat',
      series: 3,
      repetitions: 10,
      weight: 50,
      category: WorkoutCategory.strength,
      restTime: 30,
      id: '1',
    ),
    ExerciseModel(
      name: 'Panca',
      series: 3,
      repetitions: 10,
      weight: 50,
      category: WorkoutCategory.strength,
      restTime: 30,
      id: '2',
    ),
  ],
  createdAt: DateTime(2024),
  category: WorkoutCategory.strength,
);

void main() {
  late MockGetSchede mockGetSchede;
  late MockSaveScheda mockSaveScheda;
  late MockDeleteScheda mockDeleteScheda;

  setUp(() {
    mockGetSchede = MockGetSchede();
    mockSaveScheda = MockSaveScheda();
    mockDeleteScheda = MockDeleteScheda();
  });

  SchedeBloc buildBloc() => SchedeBloc(
        getSchede: mockGetSchede,
        saveScheda: mockSaveScheda,
        deleteScheda: mockDeleteScheda,
      );

  group('SchedeBloc', () {
    test('stato iniziale è SchedeInitial', () {
      expect(buildBloc().state, const SchedeInitial());
    });

    group('SchedeStarted', () {
      blocTest<SchedeBloc, SchedaState>(
        'emette [Loading, Loaded] quando getSchede ha successo',
        build: buildBloc,
        setUp: () => when(() => mockGetSchede())
            .thenAnswer((_) async => Right([tScheda])),
        act: (bloc) => bloc.add(const SchedeStarted()),
        expect: () => [
          const SchedeLoading(),
          SchedeLoaded([tScheda]),
        ],
      );

      blocTest<SchedeBloc, SchedaState>(
        'emette [Loading, Error] quando getSchede fallisce',
        build: buildBloc,
        setUp: () => when(() => mockGetSchede())
            .thenAnswer((_) async => const Left(CacheFailure())),
        act: (bloc) => bloc.add(const SchedeStarted()),
        expect: () => [
          const SchedeLoading(),
          const SchedeError('Errore nella cache locale'),
        ],
      );
    });

    group('SchedaSaved', () {
      blocTest<SchedeBloc, SchedaState>(
        'ricarica la lista dopo il salvataggio',
        build: buildBloc,
        setUp: () {
          when(() => mockSaveScheda(tScheda))
              .thenAnswer((_) async => Right(tScheda));
          when(() => mockGetSchede())
              .thenAnswer((_) async => Right([tScheda]));
        },
        act: (bloc) => bloc.add(SchedaSaved(tScheda)),
        expect: () => [
          const SchedeLoading(),
          SchedeLoaded([tScheda]),
        ],
      );
    });

    group('SchedaDeleted', () {
      blocTest<SchedeBloc, SchedaState>(
        'ricarica la lista dopo la cancellazione',
        build: buildBloc,
        setUp: () {
          when(() => mockDeleteScheda('1'))
              .thenAnswer((_) async => const Right(null));
          when(() => mockGetSchede())
              .thenAnswer((_) async => const Right([]));
        },
        act: (bloc) => bloc.add(const SchedaDeleted('1')),
        expect: () => [
          const SchedeLoading(),
          const SchedeLoaded([]),
        ],
      );
    });
  });
}