import 'package:seven/app/app.dart';

final GoRouter routes = GoRouter(
  routes: List.generate(
    AppConstants.appRoutes.length,
    (index) => GoRoute(
      path: AppConstants.appRoutes[index].path,
      pageBuilder: (context, state) =>
          FadeTransistionPage(child: AppConstants.appRoutes[index].child),
    ),
  ),
);

class FadeTransistionPage<T> extends CustomTransitionPage<T> {
  FadeTransistionPage({required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
