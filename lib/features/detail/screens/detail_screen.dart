import 'dart:developer';

import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen(this.id, {super.key});

  final String id;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  bool hasOnce = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log("Calling...");
      if (hasOnce) {
        hasOnce = false;
        ref.read(showsProvider.notifier).loadShowDetail(widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final showDetailState = ref.watch(showsProvider);

    log("Build id -> ${widget.id}");

    Widget buildBody() {
      if (showDetailState.showDetail.isLoading) {
        return CircularProgressIndicator(color: AppColors.vividNightfall4);
      }

      if (showDetailState.showDetail.isSuccess) {
        return CustomText(text: showDetailState.showDetail.title ?? "No title");
      }

      return CustomText(
          text: showDetailState.showDetail.errorMessage ?? "ERROR Details");
    }

    return Scaffold(
        appBar: customAppBar(() {
          context.pop();
        }, "Details"),
        body: Center(child: buildBody()));
  }
}
