import 'package:example/state/user/user_bloc.dart';
import 'package:example/state/user/user_cubit.dart';
import 'package:example/state/user/user_notifier.dart';
import 'package:example/state/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:unistate_provider/unistate_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiUniState(
      notifiers: [
        UserBloc(),
        UserCubit(),
        UserNotifier(),
      ],
      child: const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system,
      home: UserPage(),
    );
  }
}

