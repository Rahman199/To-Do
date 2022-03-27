import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/theme.dart';
import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();

  runApp(const MyApp());
  //NotifyHelper().initializeNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'Todo Task',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
