import 'dart:developer';
import 'package:seven/app/app.dart';

class CastCollectionScreen extends ConsumerWidget {
  const CastCollectionScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCredits = ref.watch(showCreditsProvider(id));
    final Map<String, List<CastAndCrew>> departments = {};

    void setDepartment(List<CastAndCrew> crew) {
      for (CastAndCrew people in crew) {
        final department = people.department ?? "other";
        departments.putIfAbsent(department, () => []);
        departments[department]?.add(people);
      }
    }

    log("Cast Collection - $id");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppBar(() => context.pop(), "Cast & Crew"),
        body: showCredits.when(
            data: (data) {
              setDepartment(data.crew ?? []);
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.SIDE_PADDING, vertical: 0.1.sh),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDepartment("Acting", data.cast ?? []),
                    ...departments.entries.map(
                        (entry) => _buildDepartment(entry.key, entry.value))
                  ],
                ),
              );
            },
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink()));
  }

  Widget _buildDepartment(String department, List<CastAndCrew> data) {
    if (data.isEmpty) return const SizedBox.shrink();

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(department),
          GridView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppConstants.SIDE_PADDING,
                  crossAxisSpacing: 0.5 * AppConstants.SIDE_PADDING,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) => buildCastAndCrew(data[index])),
          SizedBox(height: 0.02.sh),
          const Divider(color: AppColors.black2)
        ]);
  }
}
