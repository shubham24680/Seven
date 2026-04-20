import 'package:seven/app/app.dart';
import 'package:seven/features/collections/screens/detail_collection_screen.dart';

final GoRouter routes = GoRouter(
    initialLocation: "/",
    redirect: (context, state) async {
      final prefs = await SPD.getInstance();
      final isFirstTimeVisit = prefs.get<bool>(StorageKey.FIRST_VISIT) ?? true;

      if (isFirstTimeVisit) return "/onboarding";
      return null;
    },
    routes: [
      GoRoute(
          path: "/detail",
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final path = extra?['path'] ?? "";
            final id = extra?['id'] ?? "";
            return FadeTransistionPage(child: DetailScreen(path, id));
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
          path: "/detailCollection/:id",
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? "";
            return FadeTransistionPage(child: DetailCollectionScreen(id: id));
          }),
      GoRoute(
          path: "/genreCollection",
          pageBuilder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            final id = data?['id'] ?? "";
            return FadeTransistionPage(child: GenreCollectionScreen(id));
          }),
      GoRoute(
          path: "/castCollection/:id",
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? "";
            final type = state.extra as String?;
            return FadeTransistionPage(
                child: CastCollectionScreen(id, type ?? ""));
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
