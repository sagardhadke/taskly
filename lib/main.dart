import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/list_provider.dart';
import 'package:taskly/routes/app_routes.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => ListProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.mRoutes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
