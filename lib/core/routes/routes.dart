import 'package:seven/app/app.dart';
import 'package:seven/features/collections/screens/detail_collection_screen.dart';

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
          path: "/collection/:collectionName",
          pageBuilder: (context, state) {
            final collectionName = state.pathParameters['collectionName'] ?? "";
            final collectionProvider = state.extra
                as AsyncNotifierProvider<ShowNotifier, List<Result>>;
            return FadeTransistionPage(
                child: CollectionScreen(
                    collectionName: collectionName,
                    collectionProvider: collectionProvider));
          }),
      GoRoute(
          path: "/detailCollection/:collectionName",
          pageBuilder: (context, state) {
            final collectionName = state.pathParameters['collectionName'] ?? "";
            final detailCollection = state.extra as List<Result>;
            return FadeTransistionPage(
                child: DetailCollectionScreen(
                    collectionName: collectionName,
                    detailCollection: detailCollection));
          }),
      GoRoute(
          path: "/genreCollection/:id",
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? "";
            return FadeTransistionPage(child: GenreCollectionScreen(id));
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
