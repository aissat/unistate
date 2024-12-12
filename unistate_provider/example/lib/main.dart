import 'package:flutter/material.dart';
import 'package:unistate_adapter/unistate_bloc.dart';
import 'package:unistate_provider/unistate.dart';

import 'counter_state.dart';

void main() {
  runApp(MyApp());
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager =
        UniStateProvider.of<CounterCubit, CounterState>(context);
    // final blocListenable = CubitAdapter(stateManager);
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
      home: UniStateProvider<CounterCubit, CounterState>(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
