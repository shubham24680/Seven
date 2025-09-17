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
            (index == showsState.currentIndex)
                ? AppColors.vividNightfall4
                : AppColors.black1,
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      body: (showsState.status.isError)
          ? const ErrorScreen()
          : AppAssets.BOTTOM_NAVIGATION_ICONS[showsState.currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => showsController.moveToPage(index),
        currentIndex: showsState.currentIndex,
        backgroundColor: AppColors.black4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
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
