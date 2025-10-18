import 'package:flutter/widgets.dart';
import 'package:taskly/screens/home_page.dart';

class AppRoutes {


  static const String home = "/home";
  static const String splash = "/splash";
  static const String editNote = "/editNote";

  static Map<String, WidgetBuilder> mRoutes = {
    AppRoutes.home : (_) => HomePage()
  }; 

}