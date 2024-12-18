// import 'package:example/state/user/user_page.dart';

import 'package:example/state/user/user_bloc.dart';
import 'package:example/state/user/user_cubit.dart';
import 'package:example/state/user/user_notifier.dart';
import 'package:example/state/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unistate_provider/unistate_provider.dart';

import 'state/counter/counter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setupLocator();
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

final GetIt sl = GetIt.instance;

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();
    final counterCubit = CounterCubit();
    final counterProvider = CounterProvider();
    debugPrint('build CounterPage');
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
        spacing: 20,
        children: [
          const NotifierCounterDisplay(),
          ValueListenableBuilder(
              valueListenable: counterProvider,
              builder: (context, state, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Provider: $state'),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
          ValueListenableBuilder(
              valueListenable: counterCubit,
              builder: (context, state, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Cubit: $state'),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
          ValueListenableBuilder(
            valueListenable: counterBloc,
            builder: (context, state, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Bloc: $state'),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  counterBloc.add(Increment());
                  counterCubit.increment();
                  counterProvider.value++;
                  context.read<CounterProvider>()?.increment();
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterBloc.add(Decrement());
                  counterCubit.decrement();
                  counterProvider.decrement();
                  context.read<CounterProvider>()?.decrement();
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// void setupLocator() {
//   sl.registerLazySingleton<UserBloc>(() => UserBloc());
//   sl.registerLazySingleton<UserCubit>(() => UserCubit());
//   sl.registerLazySingleton<UserProvider>(() => UserProvider());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPage(),
      // UniState(notifier: CounterProvider(), child: CounterPage()),
    );
  }
}

class NotifierCounterDisplay extends StatelessWidget {
  const NotifierCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build NotifierCounterDisplay');
    final counterNotifier = context.watch<CounterProvider>();
    return Text(
      'Counter: ${counterNotifier?.value ?? 0}',
      style: TextStyle(fontSize: 24),
    );
  }
}
