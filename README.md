# UniState: A Universal State Management Adapter for Flutter 🚀

## Introduction

UniState is a package designed to provide a universal state management adapter for Flutter applications. It allows developers to seamlessly integrate various state management solutions while preserving Flutter's native code style and ensuring compatibility with `ValueListenableBuilder`. This package aims to offer flexibility and ease in switching between different state management approaches.

## Why UniState 🎯

- **Preserve Code Style**: Maintains consistency with Flutter's recommended code practices.
- **Unified Interface**: Provides a standardized way to manage state across different solutions like Bloc, Cubit, Provider, Getx, and Riverpod.
- **Compatibility**: Works seamlessly with Flutter's `ValueListenableBuilder`.
- **Ease of Migration**: Simplifies transitions between different state management systems with minimal code changes.
- **Decoupled Architecture**: Keeps application logic independent of specific state management implementations.

## Package Information

| Package                                                                          | Pub                                                                                                         |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [unistate_provider](https://github.com/aissat/unistate/tree/main/unistate_provider) | [![pub package](https://img.shields.io/pub/v/unistate_provider.svg)](https://pub.dev/packages/unistate_provider) |
| [unistate_adapter](https://github.com/aissat/unistate/tree/main/unistate_adapter)   | [![pub package](https://img.shields.io/pub/v/unistate_adapter.svg)](https://pub.dev/packages/unistate_adapter)   |

## Installation

Add UniState to your `pubspec.yaml`:

```yaml
dependencies:
  unistate_provider: ^latest_version
  unistate_adapter: ^latest_version
```

## Getting Started

### Basic Usage Example

Here's a simple counter app demonstrating UniState's flexibility:

```dart
// Define your state
class CounterCubit extends Cubit<int> with UnistateCubitMixin<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// Use in a Flutter widget
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManager = context.read<CounterCubit>();
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Count: ${stateManager.state}',
            style: const TextStyle(fontSize: 24),
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

| Bloc                                                                               | Cubit                                                                                | Provider                                                                                   | getx                                                                               |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| ![Bloc](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/bloc.png) | ![Cubit](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/cubit.png) | ![Provider](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/provider.png) | ![Getx](https://raw.githubusercontent.com/aissat/unistate/main/screenshots/getx.png) |

### Supported State Managers 🛠️

UniState is designed to work with multiple state management approaches, including but not limited to:

- [X] BLoC [WIP]
- [X] Cubit [WIP]
- [X] Provider [WIP]
- [X] Getx [WIP]
- [ ] Riverpod

## Key Features and Benefits 🌟

- **Agnostic Integration**: Seamlessly work with different state management libraries
- **Minimal Overhead**: Lightweight adapter that doesn't compromise performance
- **Flutter-Friendly**: Maintains the natural flow and style of Flutter development
- **Easy Migration**: Simplify transitions between state management approaches
- **Decoupled Architecture**: Keep your core application logic independent of state management details
- **Future-Proof Development**: Easily adapt to new state management trends and technologies
- **Consistent Developer Experience**: Maintain a uniform approach to state management across different parts of your application

### Troubleshooting 🛠️

- **Listener Disposal**: Always dispose of listeners to avoid memory leaks.
- **Version Compatibility**: Ensure compatibility between UniState and state management libraries.

## Documentation and Contribution 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License.
