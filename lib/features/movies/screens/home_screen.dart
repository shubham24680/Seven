import 'package:seven/app/app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeCarousel(),
          // SizedBox(height: 0.02.sh),
          // ...List.generate(
          //     _collections.length,
          //     (index) => Column(children: [
          //           if (index != 0)
          //             const Divider(
          //               color: AppColors.black2,
          //             ).paddingSymmetric(horizontal: horizontalPadding),
          //           CustomCollection(
          //               collectionName: _collections[index],
          //               isLoading: showsState.status.isLoading,
          //               result: showsState.shows.results)
          //         ]))
        ],
      ),
    );
  }
}
