import 'package:flutter/material.dart';
import 'package:unistate_provider/unistate_provider.dart';

import '../user_bloc.dart';

class UserBlocPage extends StatelessWidget {
  const UserBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager = context.read<UserBloc>(); //UserBloc();
    final user = context.watch<UserBloc>()?.value;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Text('Building By using watch',
              style: Theme.of(context).textTheme.titleMedium),
          Text(
            'Name: ${user?.name ?? ""}',
            style: const TextStyle(fontSize: 24),
          ),
          Text('Building By using ValueListenableBuilder',
              style: Theme.of(context).textTheme.titleMedium),
          ValueListenableBuilder(
            valueListenable: stateManager!,
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
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    stateManager.add(UpdateNameEvent('Jane Smith')),
                child: const Text('Update Name'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.add(UpdateAgeEvent(35)),
                child: const Text('Update Age'),
              ),
              ElevatedButton(
                onPressed: () => stateManager
                    .add(UpdateEmailEvent('jane.smith@example.com')),
                child: const Text('Update Email'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.add(ResetEvent()),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff27b499)),
                child: const Text('Reset State'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}