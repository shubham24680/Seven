import 'package:seven/app/app.dart';

class Shows extends ConsumerWidget {
  const Shows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomIcon = AppConstants.BOTTOM_NAVIGATION;
    final currentIndex = ref.watch(bottomNavigationProvider);
    final scroll = ref.watch(scrollProvider(currentIndex));

    final items = List.generate(
        bottomIcon.length,
        (index) => BottomNavigationBarItem(
            label: "Item_$index",
            icon: buildIcon(bottomIcon[index].icon, currentIndex == index)));

    final bottomNavigationBar = BottomNavigationBar(
        onTap: (index) => ref.read(bottomNavigationProvider.notifier).state = index,
        currentIndex: currentIndex,
        backgroundColor: AppColors.black4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: items);

    return Scaffold(
        body: IndexedStack(
            index: currentIndex,
            children: bottomIcon.map((w) => w.screen).toList()),
        bottomNavigationBar: AnimatedCrossFade(
            firstChild: bottomNavigationBar,
            secondChild: const SizedBox.shrink(),
            crossFadeState: scroll.crossFadeState
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300)));
  }

  Widget buildIcon(String icon, bool isSelected) {
    return SvgPicture.asset(icon,
        colorFilter: ColorFilter.mode(
            isSelected ? AppColors.vividNightfall4 : AppColors.black1,
            BlendMode.srcIn));
  }
}
