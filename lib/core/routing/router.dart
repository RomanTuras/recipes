import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/core/routing/routes.dart';
import 'package:recipes/features/favorites/favorites_screen.dart';
import 'package:recipes/features/home/home_screen.dart';
import 'package:recipes/features/main_tabs/main_tabs_screen.dart';

import '../../features/auth/auth_repository.dart';
import '../../features/recipe/recipe_screen.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  redirect: (context, state) => _redirect(context, state, authRepository),
  debugLogDiagnostics: false,
  routes: [
    /// LOGIN
    // GoRoute(
    //   path: '/login',
    //   builder: (_, __) => const LoginScreen(),
    // ),

    /// MAIN TABS ("/")
    GoRoute(
      path: Routes.home,
      builder: (_, __) => const MainTabsScreen(),
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (_, __) => HomeScreen(),
        ),
        GoRoute(
          path: Routes.favorites,
          builder: (_, __) => FavoritesScreen(),
        ),
        GoRoute(
          path: Routes.recipe,
          builder:(context, state) {
            final int id = state.extra as int;
            return RecipeScreen(id: id,);
          },
        ),
      ],
    ),
  ],
);

/// REDIRECT logic
Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
    AuthRepository authRepository,
    ) async {
  final loggedIn = await authRepository.isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;

  if (!loggedIn && !loggingIn) return Routes.login;
  if (loggedIn && loggingIn) return Routes.home;

  return null;
}