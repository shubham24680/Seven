import 'package:seven/app/app.dart';

class Shows extends ConsumerWidget {
  const Shows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);

    Widget buildIcon(String icon, int index) {
      return SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
            (index == showsState.currentIndex) ? vividNightfall5 : black1,
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      body: PageView.builder(
        controller: showsState.pageController,
        itemCount: AppAssets.BOTTOM_NAVIGATION_ICONS.length,
        onPageChanged: (index) => showsController.moveToPage(index),
        itemBuilder: (context, index) =>
            AppAssets.BOTTOM_NAVIGATION_ICONS[index].screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => showsController.jumpToPage(index),
        currentIndex: showsState.currentIndex,
        backgroundColor: black4,
        selectedItemColor: vividNightfall5,
        unselectedItemColor: lightSteel1,
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
