part of 'guess_nationality_provider.dart';

class GuessNationalityNotifier
    extends BaseStateNotifier<AppStates<GuessNationalityEntity>> {
  GuessNationalityNotifier(StateNotifierProviderRef ref)
      : repository = ref.read(guessNationalityRepositoryProvider),
        super(const AppStates.initial());

  final GuessNationalityRepository repository;

  Future<void> guess(String name) async {
    state = const AppStates.loading();
    final resp = await repository.getNationality(name);
    resp.fold(
      (failure) {
        state = AppStates.error(failure);
      },
      (data) {
        if (data.country.isEmpty) {
          state = const AppStates.empty();
        } else {
          state = AppStates.success(data);
        }
      },
    );
  }

  void reset() {
    state = const AppStates.initial();
  }
}
