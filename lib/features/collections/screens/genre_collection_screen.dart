import 'package:seven/app/app.dart';
import 'package:seven/providers/genre_collection_providers.dart';

class GenreCollectionScreen extends ConsumerWidget {
  const GenreCollectionScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genreState = ref.watch(genreCollectionProvider(id));
    final genreController = ref.read(genreCollectionProvider(id).notifier);
    final scrollState = ref.watch(genreProvider(genreCollectionProvider(id)));

    String getAppBarTitle() {
      final value = AppConstants.GENRES.firstWhere(
        (gen) => gen.id == int.tryParse(id),
        orElse: () => Result(),
      );

      return value.title ?? "";
    }

    return Scaffold(
      appBar: customAppBar(() => context.pop(), getAppBarTitle()),
      body: genreState.when(
          data: (show) => CustomCollection(
                scrollController: scrollState.scrollController,
                scrollDirection: Axis.vertical,
                orientation: CardOrientation.POTRAIT,
                crossAxisCount: 2,
                loadingItemCount: 2,
                isSafeHeight: true,
                isLoading: scrollState.isLoading,
                results: show,
              ),
          loading: () => CustomCollection(
              scrollDirection: Axis.vertical,
              orientation: CardOrientation.POTRAIT,
              crossAxisCount: 2,
              loadingItemCount: 2,
              isSafeHeight: true),
          error: (error, stackTrace) =>
              ErrorScreen(onPressed: () => genreController.refresh())),
    );
  }
}
