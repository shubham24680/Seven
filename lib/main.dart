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
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Seven",
          routerConfig: routes,
          theme: darkTheme,
        )));
  }
}
