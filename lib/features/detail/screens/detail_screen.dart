import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDetailState = ref.watch(showDetailProvider);
    final showDetailController = ref.read(showDetailProvider.notifier);
    final show = showDetailState.showDetail;

    if (show.isInitial) {
      Future.microtask(() {
        showDetailController.loadShowDetail(id);
      });
    }

    Widget buildBody() {
      if (show.isLoading) {
        return CircularProgressIndicator(color: AppColors.vividNightfall4);
      }

      if (show.isSuccess) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                imageType: ImageType.REMOTE,
                imageUrl: ApiConstants.IMAGE_PATH + (show.posterPath ?? ""),
              ),
              CustomText(text: show.title ?? ""),
              if (show.genres?.firstOrNull != null)
                ...show.genres!.map((gen) => CustomText(text: gen.name ?? "")),
              CustomText(text: show.overview ?? ""),
              CustomText(text: show.releaseDate?.toString() ?? ""),
              CustomText(text: show.runtime?.toString() ?? ""),
              CustomText(text: show.voteAverage?.toString() ?? ""),
              CustomText(text: show.status ?? ""),
            ],
          ),
        );
      }

      return CustomText(text: show.errorMessage ?? "ERROR Details");
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppBar(() {
          context.pop();
        }, show.title ?? ""),
        body: buildBody());
  }
}
