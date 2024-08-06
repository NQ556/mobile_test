import 'package:flutter/material.dart';
import 'package:mobile_test/core/utils/font_manager.dart';
import 'package:mobile_test/core/utils/route_manager.dart';
import 'package:mobile_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_test/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test/features/home/presentation/pages/home_page.dart';
import 'package:mobile_test/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<AuthBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthIsNotLoggedInState) {
            return SignInPage();
          }
          return HomePage();
        },
      ),
      theme: getApplicationTheme(),
    );
  }
}
