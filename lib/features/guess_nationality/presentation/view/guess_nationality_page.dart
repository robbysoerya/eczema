import 'package:eczema/core/core.dart';
import 'package:flutter/material.dart';

import '../providers/providers.dart';

class GuessNationalityPage extends BasePage {
  const GuessNationalityPage({super.key});

  @override
  BaseState<GuessNationalityPage> createState() => _GuessNationalityPageState();
}

class _GuessNationalityPageState extends BaseState<GuessNationalityPage>
    with BasicPageMixin, ErrorHandlingMixin {
  @override
  String screenName() => Strings.of(context).guessNationalityAppBarTitle;

  @override
  Widget body() {
    final state = ref.watch(guessNationalityStateNotifierProvider);

    if (state is GuessNationalityLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GuessNationalityFailure) {
      return errorWidget(state.failure);
    } else if (state is GuessNationalityLoaded) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                state.entity.country.length,
                (index) => Text(state.entity.country[index].countryId),
              ),
            ),
            _buildResetButton()
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputName(),
            const SizedBox(height: 16.0),
            _buildGuessButton(),
            const SizedBox(height: 24.0),
            _buildLogout(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputName() {
    return TextField(
      decoration: InputDecoration(
        hintText: Strings.of(context).guessNationalityHintTextField,
      ),
    );
  }

  Widget _buildGuessButton() {
    return ElevatedButton(
      onPressed: () {
        ref.read(guessNationalityStateNotifierProvider.notifier).guess();
      },
      child: Text(Strings.of(context).guessNationalityButtonTitle),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: () =>
          ref.read(guessNationalityStateNotifierProvider.notifier).reset(),
      child: Text(Strings.of(context).resetButtonTitle),
    );
  }

  Widget _buildLogout() {
    final isAuth = ref.read(authNotifierProvider).value;

    if (isAuth == null) return const SizedBox();

    return ElevatedButton(
      onPressed: () {
        ref.read(authNotifierProvider.notifier).logout();
      },
      child: Text(Strings.of(context).logoutTitle),
    );
  }
}
