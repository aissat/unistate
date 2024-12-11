
# UniState: A Universal State Management Adapter 📦

### Package Overview 🌐

UniState is an adapter package designed to provide an agnostic approach to state management in Flutter, offering a unified interface that seamlessly integrates with various state management systems while maintaining Flutter's native code style.

### Core Purpose 🎯

The primary goal of UniState is to:

- **Create an Adapter Layer**: Provide a flexible adapter for different state management systems 🛠️
- **Maintain Code Flexibility**: Allow easy switching between state management approaches 🔄
- **Preserve Flutter's Code Style**: Ensure consistency and idiomatic Flutter development 💻

### Why UniState? 🤔

Developers often face challenges when:

- Choosing a state management solution ⚖️
- Migrating between different state management systems 🔄
- Maintaining a consistent code structure 📂

UniState solves these problems by providing a universal adapter that:

- Decouples your application logic from specific state management implementations 🧩
- Provides a consistent interface across different state management approaches 🛠️
- Allows for easy experimentation and migration between state management systems 🔄

### The State Management Landscape 🌍

Flutter offers numerous state management solutions, each with its unique code style and philosophy. Developers often face challenges when:

- Choosing a state management approach 🔍
- Migrating between different state management systems 🔄
- Avoiding tight coupling to a specific state management library 🔒

### Our Philosophy 💡

The primary purpose of UniState is to:

- **Create an Adapter Layer**: Provide a flexible adapter for different state management systems 🧩
- **Maintain Code Flexibility**: Allow easy switching between state management approaches 🔄
- **Preserve Flutter's Code Style**: Ensure consistency and idiomatic Flutter development 💻
- **Preserve Your Code**: Protect your application's core logic from changes caused by state management system shifts 🛡️

### Supported State Managers 🧳

UniState is designed to work with multiple state management approaches, including but not limited to:

- BLoC (Business Logic Component) 💼
- Provider 🏷️
- Riverpod 🌱
- Cubit 🪄
- Custom State Management Solutions 🛠️

### Key Features 🔑

- **Agnostic Integration**: Seamlessly work with different state management libraries 🔄
- **Minimal Overhead**: Lightweight adapter that doesn't compromise performance ⚡
- **Flutter-Friendly**: Maintains the natural flow and style of Flutter development 🌟
- **Easy Migration**: Simplify transitions between state management approaches 🛣️

### Key Components 🧩

#### UniState Package 📦

##### Overview

The `unistate` package provides a structured approach to state management, allowing developers to manage application state efficiently and integrate it seamlessly with the Flutter widget tree 🌳.

##### Key Components

- **`UniState<T>`**: An abstract class defining a contract for managing state, with methods for getting, updating, and resetting the state 🔄.
- **`UniStateProvider<T, S>`**: A `StatefulWidget` that manages the lifecycle of a `UniState` instance and provides it to the widget tree 🌳.
- **Extensions**: Methods like `read` and `watch` on `BuildContext` to interact with the state 👀.

#### UniStateBloc Package 📦

##### Overview

The `unistate_bloc` package extends the functionality of the `unistate` package by integrating with the `flutter_bloc` package, providing adapters for bloc and cubit state management 🔄.

##### Key Components

- **`BlocAdapter<S, E>`**: An adapter that listens to a `Bloc` and updates its value for reactive UI updates 🔄.
- **`CubitAdapter<T>`**: An adapter that listens to a `Cubit` and updates its value for reactive UI updates 🔄.
- **Extensions**: Methods to convert `Bloc` and `Cubit` instances into `ValueListenable` 📈.

### Key Features and Benefits 🎉

- **Agnostic Integration**: Seamlessly work with different state management libraries 🔄
- **Minimal Overhead**: Lightweight adapter that doesn't compromise performance ⚡
- **Flutter-Friendly**: Maintains the natural flow and style of Flutter development 🌟
- **Easy Migration**: Simplify transitions between state management approaches 🛣️
- **Decoupled Architecture**: Keep your core application logic independent of state management details 🧩
- **Future-Proof Development**: Easily adapt to new state management trends and technologies 🔮
- **Consistent Developer Experience**: Maintain a uniform approach to state management across different parts of your application 🧑‍💻

### Example Concept 📝

```dart
// Unified state management interface
abstract class UniState<T> {
  T get state;
  void updateState(T newState);
  void dispose();
}
// Adapter for different state managers
class StateManagerAdapter<T> implements UniState<T> {
  // Adapt various state management systems
  // (BLoC, Provider, Cubit, etc.)
}
```

## Getting Started 🚀

### Installation 🔧

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  unistate: ^latest_version
  unistate_bloc: ^latest_version
```

### Basic Usage Example 🖥️

Here's a simple counter app demonstrating UniState's flexibility:

```dart
// Define your state
class CounterState {
  final int count;
  CounterState({required this.count});
}

// Create a state manager implementing UniState
class CounterCubit extends Cubit<CounterState> implements UniState<CounterState> {
  CounterCubit() : super(CounterState(count: 0));

  @override
  void performAction(String actionType, [dynamic payload]) {
    switch (actionType) {
      case 'increment':
        emit(CounterState(count: state.count + 1));
        break;
      case 'decrement':
        emit(CounterState(count: state.count - 1));
        break;
    }
  }

  @override
  void updateState(CounterState newState) {
    emit(newState);
  }

  @override
  void resetState() {
    emit(CounterState(count: 0));
  }
}

// Use in a Flutter widget
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManager = UniStateProvider.of<CounterCubit, CounterState>(context);
  
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: stateManager.asValueListenable(),
            builder: (context, state, child) {
              return Text('Count: ${state.count}');
            },
          ),
          ElevatedButton(
            onPressed: () => stateManager.performAction('increment'),
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```

### Key Concepts 🧠

- **UniState Interface**: Provides a consistent method for state management 🛠️
- **Flexible Adapters**: Works with various state management libraries 🔄
- **Easy State Manipulation**: Use `performAction()` for state changes 🔄

### Supported State Managers ✅

- [ ] BLoC [WIP]
- [ ] Cubit [WIP]
- [ ] Provider
- [ ] Riverpod

- Custom State Management Solutions 🛠️

### Migration and Compatibility 🔄

UniState makes it easy to:

- Switch between state management approaches 🔄
- Maintain consistent code structure 📂
- Decouple application logic from state management details 🧩

## Troubleshooting 🛠️

- Ensure you've imported the necessary packages 📦
- Check that your state manager implements the `UniState` interface 🛠️
- Use `UniStateProvider` to wrap your widget tree 🌳

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request 🔄.

## License 📜

This project is licensed under the MIT License.
