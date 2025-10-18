import 'package:flutter/widgets.dart';
import 'package:taskly/screens/edit_note.dart';
import 'package:taskly/screens/home_page.dart';
import 'package:taskly/screens/splash_page.dart';

class AppRoutes {
  static const String home = "/home";
  static const String splash = "/splash";
  static const String editNote = "/editNote";

  static Map<String, WidgetBuilder> mRoutes = {
    AppRoutes.home: (_) => HomePage(),
    AppRoutes.splash : (_) => SplashPage(),
    AppRoutes.editNote: (_) => EditNote(),
  };
}
