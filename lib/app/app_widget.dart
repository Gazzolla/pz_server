import 'package:fluent_ui/fluent_ui.dart';
import 'package:project_zomboid_server/app/modules/home/home.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      supportedLocales: [Locale('en')],
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
