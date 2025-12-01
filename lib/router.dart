import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:premi_1/Home/home_page.dart';

import 'package:premi_1/Todos/todos_page.dart';

import 'login/view/login_page.dart';

Map<String, Widget> pages = {
  'todos': const TodosPage(),
};

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && (snapshot.data?.emailVerified ?? false)) {
              return const HomePage();
            }
            return const LoginPage();
          },
        );
      },
      routes: [
        for (String page in pages.keys)
          GoRoute(
            path: page,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 500),
                key: state.pageKey,
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        (snapshot.data?.emailVerified ?? false)) {
                      return pages[page]!;
                    }
                    return const LoginPage();
                  },
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
      ],
    ),
  ],
);
