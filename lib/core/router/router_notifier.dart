import 'dart:async';

import 'package:eczema/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, bool>(() {
  return RouterNotifier();
});

class RouterNotifier extends AutoDisposeAsyncNotifier<bool>
    implements Listenable {
  VoidCallback? routerListener;

  @override
  Future<bool> build() async {
    // watch more providers and write logic accordingly
    final isAuth = await ref.watch(
      authNotifierProvider.selectAsync((data) => data != null),
    );

    ref.listenSelf((_, __) {
      // write more conditional logic for when to call redirection
      if (state.isLoading) return;
      routerListener?.call();
    });

    return isAuth;
  }

  //Redirect the user when authentication state changes
  String? redirect(BuildContext context, GoRouterState state) {
    final isAuth = this.state.valueOrNull;

    if (isAuth == null) return RouterConstant.loginPage;
    // final isSplash = state.location == RouterConstant.splashPage;

    // if (isSplash) {
    //   return isAuth
    //       ? RouterConstant.guessNationalityPage
    //       : RouterConstant.loginPage;
    // }

    final isLoggingIn = state.location == RouterConstant.loginPage;
    if (isLoggingIn) return isAuth ? RouterConstant.guessNationalityPage : null;

    return isAuth ? null : RouterConstant.loginPage;
  }

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}
