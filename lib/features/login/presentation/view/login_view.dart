import 'package:eczema/core/core.dart';
import 'package:eczema/features/login/login.dart';
import 'package:flutter/material.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  BaseState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage>
    with BasicPageMixin, ErrorHandlingMixin {
  @override
  String screenName() => Strings.of(context).loginTitle;

  @override
  Widget body() {
    final state = ref.watch(loginStateNotifierProvider);

    if (state is LoginLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: Strings.of(context).loginUsernameHint,
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: Strings.of(context).loginPasswordHint,
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                ref.read(loginStateNotifierProvider.notifier).login();
              },
              child: Text(Strings.of(context).loginTitle),
            ),
          ],
        ),
      ),
    );
  }
}
