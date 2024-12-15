import 'package:example/user_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unistate_adapter/unistate_adapter.dart';
import 'package:unistate_provider/unistate.dart';

import 'counter_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    MyApp(),
    // UniStateMultiProvider(
    //   providers: [
    //     UniStateProvider(create: (context) => UserBloc()),
    //     UniStateProvider(create: (context) => UserCubit()),
    //     UniStateProvider(create: (context) => UserProvider()),
    //   ],
    //   // create: (context) => UserBloc(),
    //   child: const MyApp(),
    // ),
    // const MyApp(),
  );
}

final GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<UserBloc>(() => UserBloc());
  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerLazySingleton<UserProvider>(() => UserProvider());
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager = context.get<CounterCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: stateManager.asValueListenable(),
            builder: (context, state, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Count: ${state.count}'),
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
                onPressed: () => stateManager.performAction('increment'),
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('decrement'),
                child: const Text('Decrement'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPage(),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bloc'),
              Tab(text: 'Cubit'),
              Tab(text: 'Provider'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _UserBlocSection(),
            _UserCubitSection(),
            _UserProviderSection(),
          ],
        ),
      ),
    );
  }
}

class _UserBlocSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final stateManager = UniStateProvider.of<UserBloc>(context);
    final stateManager = context.get<UserBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder(
            valueListenable: stateManager.asValueListenable(),
            builder: (context, state, child) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bloc - Name: ${state.name}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Bloc - Age: ${state.age}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Bloc - Email: ${state.email}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                  'updateUser',
                  UserState(
                      name: 'John Doe', age: 30, email: 'john.doe@example.com'),
                ),
                child: const Text('Update Full Profile'),
              ),
              ElevatedButton(
                onPressed: () =>
                    stateManager.performAction('updateName', 'Jane Smith'),
                child: const Text('Update Name'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('updateAge', 35),
                child: const Text('Update Age'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                    'updateEmail', 'jane.smith@example.com'),
                child: const Text('Update Email'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('reset'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reset State'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserCubitSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManager = context.get<UserCubit>();

    // final stateManager = UniStateProvider.of<UserCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder(
            valueListenable: stateManager.asValueListenable(),
            builder: (context, state, child) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cubit - Name: ${state.name}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Cubit - Age: ${state.age}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Cubit - Email: ${state.email}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                  'updateUser',
                  UserState(
                      name: 'John Doe', age: 30, email: 'john.doe@example.com'),
                ),
                child: const Text('Update Full Profile'),
              ),
              ElevatedButton(
                onPressed: () =>
                    stateManager.performAction('updateName', 'Jane Smith'),
                child: const Text('Update Name'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('updateAge', 35),
                child: const Text('Update Age'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                    'updateEmail', 'jane.smith@example.com'),
                child: const Text('Update Email'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('reset'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reset State'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserProviderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManager = context.get<UserProvider>();
    // var counterNotifier = ValueNotifier<UserState>(stateManager.state);
    // var counterNotifier = stateManager();
    // final stateManager = UniStateProvider.of<UserCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder(
            valueListenable: stateManager,
            builder: (context, state, child) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Provider - Name: ${state.name}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Provider - Age: ${state.age}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Provider - Email: ${state.email}',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                  'updateUser',
                  UserState(
                      name: 'John Doe', age: 30, email: 'john.doe@example.com'),
                ),
                child: const Text('Update Full Profile'),
              ),
              ElevatedButton(
                onPressed: () =>
                    stateManager.performAction('updateName', 'Jane Smith'),
                child: const Text('Update Name'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('updateAge', 35),
                child: const Text('Update Age'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction(
                    'updateEmail', 'jane.smith@example.com'),
                child: const Text('Update Email'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.performAction('reset'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reset State'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
