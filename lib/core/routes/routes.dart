import 'package:seven/app/app.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final prefs = await SPD.getInstance();
    final isFirstTimeVisit = prefs.isFirstTimeVisit;

    if (isFirstTimeVisit) return "/onboarding";
    return null;
  },
  routes: List.generate(
    AppConstants.APP_ROUTES.length,
    (index) => GoRoute(
      path: AppConstants.APP_ROUTES[index].path,
      pageBuilder: (context, state) =>
          FadeTransistionPage(child: AppConstants.APP_ROUTES[index].child),
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
