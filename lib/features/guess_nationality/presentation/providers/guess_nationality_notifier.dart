import 'package:eczema/core/base/base_state_notifier.dart';
import 'package:eczema/core/data/repositories/guess_nationality_repository_impl.dart';
import 'package:eczema/core/domain/repositories/guess_nationality_repository.dart';
import 'package:eczema/features/guess_nationality/presentation/providers/guess_nationality_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guessNationalityStateNotifierProvider =
    StateNotifierProvider((ref) => GuessNationalityNotifier(ref));

class GuessNationalityNotifier
    extends BaseStateNotifier<GuessNationalityState> {
  GuessNationalityNotifier(StateNotifierProviderRef ref)
      : repository = ref.read(guessNationalityRepositoryProvider),
        super(GuessNationalityInitial());

  final GuessNationalityRepository repository;

  Future<void> guess() async {
    state = GuessNationalityLoading();
    final resp = await repository.getNationality();
    resp.fold(
      (failure) {
        state = GuessNationalityFailure(failure: failure);
      },
      (data) {
        state = GuessNationalityLoaded(entity: data);
      },
    );
  }
}
