import 'dart:io';
import 'package:seven/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Seven');
    // setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(700, 600));
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Seven",
        routerConfig: routes,
        theme: darkTheme,
      ),
    );
  }
}
