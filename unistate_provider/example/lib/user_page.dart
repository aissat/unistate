import 'package:example/state/user/user.dart';
import 'package:flutter/material.dart';
import 'package:unistate_provider/unistate_provider.dart';

import 'state/user/user_notifier.dart';
// or import 'user_cubit.dart';
// or import 'user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UniState(
      notifier: UserNotifier(),
      child: UserView(),
    );
  }
}

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build UserView');
    final userNotifier = context.watch<UserNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Column(
        children: [
          Text(
            'Name: ${userNotifier?.value.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ValueListenableBuilder<User>(
            valueListenable: userNotifier!,
            builder: (context, user, child) {
              debugPrint('build ValueListenableBuilder');
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text('Name: ${user.name}'),
                    Text('Age: ${user.age}'),
                    Text('Email: ${user.email}'),
                    ElevatedButton(
                      onPressed: () => userNotifier.updateName('John Doe'),
                      child: const Text('Update Name'),
                    ),
                    ElevatedButton(
                      onPressed: () => userNotifier.updateAge(35),
                      child: const Text('Update Age'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          userNotifier.updateEmail('john.doe@example.com'),
                      child: const Text('Update Email'),
                    ),
                    ElevatedButton(
                      onPressed: () => userNotifier.reset(),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Reset State'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class UserView extends StatelessWidget {
//   const UserView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userNotifier = context.watch<UserNotifier>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('User Details')),
//       body: ValueListenableBuilder<User>(
//           valueListenable: userNotifier,
//           builder: (context, value, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Name: ${value.name}'),
//                 Text('Age: ${value.age}'),
//                 Text('Email: ${value.email}'),
//                 ElevatedButton(
//                   onPressed: () => userNotifier.updateName('John Doe'),
//                   child: const Text('Update Name'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => userNotifier.updateAge(35),
//                   child: const Text('Update Age'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () =>
//                       userNotifier.updateEmail('john.doe@example.com'),
//                   child: const Text('Update Email'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => userNotifier.reset(),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text('Reset State'),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
