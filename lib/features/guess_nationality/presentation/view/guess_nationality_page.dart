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
  final _controller = TextEditingController();

  @override
  String screenName() => Strings.of(context).guessNationalityAppBarTitle;

  _buildSuccess(GuessNationalityEntity entity) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              entity.country.length,
              (index) => Text(entity.country[index].countryId),
            ),
          ),
          _buildResetButton()
        ],
      ),
    );
  }

  _buildInitial() {
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

  @override
  Widget body() {
    final state = ref.watch(guessNationalityNotifierProvider);
    return state.when(
      initial: () => _buildInitial(),
      loading: () => const Center(child: CircularProgressIndicator()),
      empty: () => const Text('Data tidak ditemukan'),
      success: (data) => _buildSuccess(data),
      error: (failure) => errorWidget(failure),
    );
  }

  Widget _buildInputName() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: Strings.of(context).guessNationalityHintTextField,
      ),
    );
  }

  Widget _buildGuessButton() {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(guessNationalityNotifierProvider.notifier)
            .guess(_controller.text);
      },
      child: Text(Strings.of(context).guessNationalityButtonTitle),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: () =>
          ref.read(guessNationalityNotifierProvider.notifier).reset(),
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
