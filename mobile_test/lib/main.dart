import 'package:flutter/material.dart';
import 'package:mobile_test/core/utils/font_manager.dart';
import 'package:mobile_test/core/utils/route_manager.dart';
import 'package:mobile_test/features/login/presentation/pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      home: SignInPage(),
      theme: getApplicationTheme(),
    );
  }
}
