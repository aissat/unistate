import 'package:flutter/material.dart';
import 'package:unistate_provider/unistate_provider.dart';

import '../user_cubit.dart';

class UserCubitPage extends StatelessWidget {
  const UserCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager = context.read<UserCubit>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Text('Building By using watch',
              style: Theme.of(context).textTheme.titleMedium),
          _UserNameDisplay(),
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
              // ElevatedButton(
              //   onPressed: () => stateManager.performAction(
              //     'updateUser',
              //     UserState(
              //         name: 'John Doe', age: 30, email: 'john.doe@example.com'),
              //   ),
              //   child: const Text('Update Full Profile'),
              // ),
              ElevatedButton(
                onPressed: () => stateManager.updateName('Jane Smith'),
                child: const Text('Update Name'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.updateAge(35),
                child: const Text('Update Age'),
              ),
              ElevatedButton(
                onPressed: () =>
                    stateManager.updateEmail('jane.smith@example.com'),
                child: const Text('Update Email'),
              ),
              ElevatedButton(
                onPressed: () => stateManager.reset(),
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

class _UserNameDisplay extends StatelessWidget {
  const _UserNameDisplay();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>()?.value;
    return Text(
      'Name: ${user?.name ?? ""}',
      style: const TextStyle(fontSize: 24),
    );
  }
}
