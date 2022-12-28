import 'package:eczema/core/core.dart';
import 'package:eczema/features/guess_nationality/guess_nationality.dart';
import 'package:eczema/features/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final sub = ref.listen(routerNotifierProvider, (_, __) {});
  ref.onDispose(sub.close);

  final notifier = ref.read(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: RouterConstant.loginPage,
    observers: [RouterObserver()],
    routes: routes,
    redirect: notifier.redirect,
  );
});

List<GoRoute> get routes {
  return [
    GoRoute(
      name: 'home',
      path: RouterConstant.guessNationalityPage,
      builder: (context, state) => const GuessNationalityPage(),
    ),
    GoRoute(
      name: 'login',
      path: RouterConstant.loginPage,
      builder: (context, state) => const LoginPage(),
    ),
  ];
}
