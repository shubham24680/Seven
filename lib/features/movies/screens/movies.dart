import 'package:seven/app/app.dart';

class Movies extends ConsumerWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      body: const Center(child: CustomText(text: "text")),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => ref.read(currentIndexProvider.notifier).state = index,
        currentIndex: currentIndex,
        backgroundColor: black4,
        selectedItemColor: vividNightfall5,
        unselectedItemColor: black1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
