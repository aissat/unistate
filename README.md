# UniState: A Universal State Management Adapter 🚀

| Package                                                                          | Pub                                                                                                         |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [unistate_provider](https://github.com/aissat/unistate/tree/main/unistate_provider) | [![pub package](https://img.shields.io/pub/v/unistate_provider.svg)](https://pub.dev/packages/unistate_provider) |
| [unistate_adapter](https://github.com/aissat/unistate/tree/main/unistate_adapter)   | [![pub package](//img.shields.io/pub/v/unistate_adapter.svg)](https://pub.dev/packages/unistate_adapter)         |

Package Overview  📦  [![pub package](https://img.shields.io/pub/v/unistate.svg)](https://pub.dev/packages/unistate)

UniState is an adapter package designed to provide an agnostic approach to state management in Flutter, offering a unified interface that seamlessly integrates with various state management systems while maintaining Flutter's native code style.

### Core Purpose 🎯

The primary goal of UniState is to:

- **Create an Adapter Layer**: Provide a flexible adapter for different state management systems to ensure compatibility with Flutter's native widget `ValueListenableBuilder`
- **Maintain Code Flexibility**: Allow easy switching between state management approaches
- **Preserve Flutter's Code Style**: Ensure consistency and idiomatic Flutter development

| Bloc                                                                               | Cubit                                                                                | Provider                                                                                   | getx                                                                               |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| ![Bloc](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/bloc.png) | ![Cubit](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/cubit.png) | ![Provider](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/provider.png) | ![Getx](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/getx.png) |

### Why UniState? 🤔

Developers often face challenges when:

- Choosing a state management solution
- Migrating between different state management systems
- Maintaining a consistent code structure

UniState solves these problems by providing a universal adapter that:

- Decouples your application logic from specific state management implementations
- Provides a consistent interface across different state management approaches
- Allows for easy experimentation and migration between state management systems

### The State Management Landscape 🌐

Flutter offers numerous state management solutions, each with its unique code style and philosophy. Developers often face challenges when:

- Choosing a state management approach
- Migrating between different state management systems
- Avoiding tight coupling to a specific state management library

### Our Philosophy 💡

The primary purpose of UniState is to:

- **Create an Adapter Layer**: Provide a flexible adapter for different state management systems
- **Maintain Code Flexibility**: Allow easy switching between state management approaches
- **Preserve Flutter's Code Style**: Ensure consistency and idiomatic Flutter development
- **Preserve Your Code**: Protect your application's core logic from changes caused by state management system shifts

### Supported State Managers 🛠️

UniState is designed to work with multiple state management approaches, including but not limited to:

- BLoC
- Cubit
- Provider
- Getx
- Riverpod
- Custom State Management Solutions

## Key Features and Benefits 🌟

- **Agnostic Integration**: Seamlessly work with different state management libraries
- **Minimal Overhead**: Lightweight adapter that doesn't compromise performance
- **Flutter-Friendly**: Maintains the natural flow and style of Flutter development
- **Easy Migration**: Simplify transitions between state management approaches
- **Decoupled Architecture**: Keep your core application logic independent of state management details
- **Future-Proof Development**: Easily adapt to new state management trends and technologies
- **Consistent Developer Experience**: Maintain a uniform approach to state management across different parts of your application

### Key Components 🔑

#### UniState Core Interfaces

##### `UniState<T extends Listenable>`

- **Purpose**: Defines a standardized contract for state management
- **Key Features**:
  - InheritedNotifier-based implementation
  - Provides state to the widget tree
  - Dependency injection for state management

##### `MultiUniState`

- **Purpose**: Manage multiple state lifecycles and provide states to the widget tree
- **Key Features**:
  - Manage multiple `Listenable` objects
  - Reactive state propagation
  - Scoped state management

#### UniState Adapter Components

##### `UnistateBlocMixin<Event, State>`

- **Purpose**: Make BLoC state holder compatible with `ValueListenable`
- **Key Capabilities**:
  - Listen to Bloc state changes
  - Transform Bloc events to reactive state updates
  - Minimal performance overhead

##### `UnistateCubitMixin<State>`

- **Purpose**: Make Cubit state holder compatible with `ValueListenable`
- **Key Capabilities**:
  - Reactive state transformation
  - Simplified state observation
  - Compatibility with Flutter's reactive programming model

##### `UnistateNotifierMixin<T>`

- **Purpose**: Make Notifier state holder compatible with `ValueListenable`
- **Key Capabilities**:
  - Reactive state transformation
  - Simplified state observation
  - Compatibility with Flutter's reactive programming model

##### `UnistateListenableMixin<T>`

- **Purpose**: Make any state holder compatible with `ValueListenable`
- **Key Capabilities**:
  - Provide current state as `ValueListenable`
  - Add and remove listeners for state changes

#### Extension Methods 🧩

##### State Interaction Extensions

- `read<T>()`: Synchronously read current state
- `watch<T>()`: Listen to state changes reactively

## Packages 📦

1. UniState Adapter

#### Purpose

The UniState Adapter is a powerful package that standardizes state management by converting various state management solutions to a unified `ValueListenable` interface.

#### Key Features

- Convert Bloc to ValueListenable
- Convert Cubit to ValueListenable
- Type-safe state transformations
- Seamless integration with existing state management patterns

#### Use Cases

- Migrate between state management solutions
- Standardize state handling across different components
- Simplify complex state management logic

### 2. UniState Provider

#### Purpose

UniState Provider offers a lightweight, flexible state management solution using the provider pattern with enhanced ValueListenable support.

#### Key Features

- Simple and intuitive provider pattern implementation
- Deep integration with ValueListenable
- Modular state management
- Minimal boilerplate code
- Type-safe state handling

#### Use Cases

- Build scalable Flutter applications
- Manage local and global application state
- Create reactive UI components

## Getting Started 🚀

### Installation

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  unistate: ^latest_version
  unistate_bloc: ^latest_version
```

### Basic Usage Example 📋

Here's a simple counter app demonstrating UniState's flexibility:

> You can find the complete example in the [repository](https://github.com/aissat/unistate/tree/main/example).

```dart
// Define your state
class CounterCubit extends Cubit<int> with UnistateCubitMixin<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
} 

class _CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterCubit>()?.state;
    return Text(
      'count: $count',
      style: const TextStyle(fontSize: 24),
    );
  }
}

// Use in a Flutter widget
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManager = context.read<CounterCubit>();
    return Scaffold(
      body: Column(
        children: [
          _CounterDisplay(),
          ValueListenableBuilder(
            valueListenable: stateManager!,
            builder: (context, state, child) {
              return Text('Count: $state');
            },
          ),
          ElevatedButton(
            onPressed: () => stateManager.increment(),
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```

### Key Concepts 📚

- **UniState**: Provides a unified interface for state management
- **Flexible Adapters**: Works with various state management libraries
- **Easy State Manipulation**: Provides a unified interface for state manipulation
- **ValueListenable**: Enables reactive state management

### Supported State Managers 🛠️

- [X] BLoC [WIP]
- [X] Cubit [WIP]
- [X] Provider [WIP]
- [X] Getx [WIP]
- [ ] Riverpod

- Custom State Management Solutions

### Migration and Compatibility 🔄

UniState makes it easy to:

- Switch between state management approaches
- Maintain consistent code structure
- Decouple application logic from state management details

## Troubleshooting 🛠️

- Ensure you've imported the necessary packages
- Check that your state manager implements the `UniState` interface
- Use `UniStateProvider` to wrap your widget tree

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License.
