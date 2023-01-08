import 'package:eczema/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'guess_nationality_notifier.dart';

final guessNationalityNotifierProvider = StateNotifierProvider.autoDispose<
    GuessNationalityNotifier, AppStates<GuessNationalityEntity>>(
  (ref) => GuessNationalityNotifier(ref),
);
