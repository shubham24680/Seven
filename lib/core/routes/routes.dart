import 'package:seven/app/app.dart';

final GoRouter routes = GoRouter(
    initialLocation: "/",
    redirect: (context, state) async {
      final prefs = await SPD.getInstance();
      final isFirstTimeVisit = prefs.isFirstTimeVisit;

      if (isFirstTimeVisit) return "/onboarding";
      return null;
    },
    routes: [
      GoRoute(
          path: "/detail/:id",
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? "";
            return FadeTransistionPage(child: DetailScreen(id));
          }),
      GoRoute(
          path: "/collection/:id",
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? "";
            final collectionName = state.extra as String;
            return FadeTransistionPage(
                child:
                    CollectionScreen(id: id, collectionName: collectionName));
          }),
      ...List.generate(
        AppConstants.APP_ROUTES.length,
        (index) => GoRoute(
          path: AppConstants.APP_ROUTES[index].path,
          pageBuilder: (context, state) =>
              FadeTransistionPage(child: AppConstants.APP_ROUTES[index].child),
        ),
      )
    ]);

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
