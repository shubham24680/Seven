import 'package:seven/app/app.dart';

class Movies extends ConsumerWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieState = ref.watch(movieProvider);
    final movieController = ref.read(movieProvider.notifier);

    Widget buildIcon(String icon, int index) {
      return SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
            (index == movieState.currentIndex) ? vividNightfall5 : black1,
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      body: PageView.builder(
        controller: movieState.pageController,
        itemCount: AppAssets.BOTTOM_NAVIGATION_ICONS.length,
        onPageChanged: (index) => movieController.moveToPage(index),
        itemBuilder: (context, index) =>
            AppAssets.BOTTOM_NAVIGATION_ICONS[index].screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => movieController.jumpToPage(index),
        currentIndex: movieState.currentIndex,
        backgroundColor: black4,
        selectedItemColor: vividNightfall5,
        unselectedItemColor: black1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: List.generate(
          AppAssets.BOTTOM_NAVIGATION_ICONS.length,
          (index) => BottomNavigationBarItem(
            icon:
                buildIcon(AppAssets.BOTTOM_NAVIGATION_ICONS[index].icon, index),
            label: "Item$index",
          ),
        ),
      ),
    );
  }
}
