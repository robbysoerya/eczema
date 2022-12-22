import 'package:eczema/core/core.dart';
import 'package:eczema/core/utils/localizations_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eczema/features/guess_nationality/presentation/providers/providers.dart';

class GuessNationalityPage extends BasePage {
  const GuessNationalityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GuessNationalityPageState();
}

class _GuessNationalityPageState extends BaseState<GuessNationalityPage>
    with BasicPageMixin {

  @override
  String screenName() => Strings.of(context).guessNationalityAppBarTitle;

  @override
  Widget body() {
    final state = ref.watch(guessNationalityStateNotifierProvider);

    if (state is GuessNationalityLoading) {
      return const CircularProgressIndicator();
    } else if (state is GuessNationalityFailure) {
      return Text(state.failure.message);
    } else if (state is GuessNationalityLoaded) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            state.entity.country.length,
            (index) => Text(state.entity.country[index].countryId),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: Strings.of(context).guessNationalityHintTextField,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(guessNationalityStateNotifierProvider.notifier)
                    .guess();
              },
              child: Text(Strings.of(context).guessNationalityButtonTitle),
            ),
          ],
        ),
      ),
    );
  }
}
