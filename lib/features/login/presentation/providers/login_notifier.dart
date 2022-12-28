import 'package:eczema/core/core.dart';
import 'package:eczema/features/login/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final loginStateNotifierProvider = StateNotifierProvider((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends BaseStateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(LoginInitial());
  final Ref ref;

  Future<void> login() async {
    state = LoginLoading();
    final box = Hive.box('config');
    box.put("isLogin", true);
    await Future.delayed(const Duration(seconds: 3));
    ref.read(authNotifierProvider.notifier).login(true);
    state = LoginLoaded(value: true);
  }
}
