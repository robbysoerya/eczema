import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final authNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AuthNotifier, bool?>(() {
  return AuthNotifier();
});

class AuthNotifier extends AutoDisposeAsyncNotifier<bool?> {
  @override
  FutureOr<bool?> build() async {
    _persistenceRefreshLogic();
    return await _loginRecoveryAttempt();
  }

  Future<bool?> _loginRecoveryAttempt() async {
    final box = Hive.box('config');
    try {
      final savedToken = box.get('isLogin');
      if (savedToken == null) {
        throw Exception("Couldn't find the authentication token");
      }

      return await _loginWithToken(savedToken);
    } catch (_, __) {
      await box.delete('isLogin');
      return null;
    }
  }

  Future<bool> _loginWithToken(String token) async {
    final loginAttempt = await Future.delayed(
      const Duration(seconds: 3),
      () => true,
    );
    if (loginAttempt) return true;

    throw Exception('401 Unauthorized request');
  }

  Future<void> login(bool value) async {
    state = await AsyncValue.guard<bool>(
      () => Future.value(value),
    );
  }

  Future<void> logout() async {
    state = await AsyncValue.guard<bool?>(
      () => Future.value(null),
    );
  }

  void _persistenceRefreshLogic() {
    final box = Hive.box('config');
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        box.delete('isLogin');
        return;
      }

      final val = next.requireValue;
      final isAuthenticated = val == null;

      isAuthenticated ? box.delete('isLogin') : box.put('isLogin', val);
    });
  }
}
