import 'package:seven/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DimensionUtilInit(
        scaleType: ScaleType.WIDTH,
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;
            return MaterialApp.router(
              key: ValueKey('app_router_$screenWidth'),
              debugShowCheckedModeBanner: false,
              title: "Seven",
              routerConfig: routes,
              theme: darkTheme,
            );
          },
        child: SizedBox.shrink()));
  }
}
