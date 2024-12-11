import 'package:flutter/material.dart';

import 'unistate.dart';

/// A provider widget for managing and accessing a [UniState] instance.
///
/// This widget uses a [StatefulWidget] to manage the lifecycle of a
/// [UniState] object and expose it to the widget tree.
class UniStateProvider<T extends UniState<S>, S> extends StatefulWidget {
  /// A function that creates the [UniState] instance.
  final T Function(BuildContext) create;

  /// The child widget that can access the [UniState] instance.
  final Widget child;

  /// Creates a [UniStateProvider] with the given [create] function and [child].
  const UniStateProvider({
    super.key,
    required this.create,
    required this.child,
  });

  @override
  State<UniStateProvider<T, S>> createState() => _UnistateProviderState<T, S>();

  /// Retrieves the [UniState] instance from the nearest ancestor.
  ///
  /// Returns null if no ancestor [UniStateProvider] is found.
  static T? maybeOf<T extends UniState<S>, S>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedUnistateProvider<T, S>>()
        ?.manager;
  }

  /// Retrieves the [UniState] instance from the nearest ancestor.
  ///
  /// Throws a [FlutterError] if no ancestor [UniStateProvider] is found.
  static T of<T extends UniState<S>, S>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<_InheritedUnistateProvider<T, S>>();
    if (provider == null) {
      throw FlutterError(
        'UniStateProvider.of() called with a context that does not contain an UniStateProvider.',
      );
    }
    return provider.manager;
  }
}

/// An inherited widget that holds a [UniState] manager.
class _InheritedUnistateProvider<T extends UniState<S>, S>
    extends InheritedWidget {
  /// The [UniState] manager instance.
  final T manager;

  /// Creates an [_InheritedUnistateProvider] with the given [manager] and [child].
  const _InheritedUnistateProvider({
    super.key,
    required this.manager,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedUnistateProvider<T, S> oldWidget) {
    return manager != oldWidget.manager;
  }
}

/// The state class for [UniStateProvider].
class _UnistateProviderState<T extends UniState<S>, S>
    extends State<UniStateProvider<T, S>> {
  /// The [UniState] manager instance.
  late T manager;

  @override
  Widget build(BuildContext context) {
    return _InheritedUnistateProvider<T, S>(
      manager: manager,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    manager = widget.create(context);
  }
}

/// Extension methods for [BuildContext] to interact with [UniStateProvider].
extension UnistateProviderExtension<T extends UniState<S>, S> on BuildContext {
  /// Reads the current state without listening to changes.
  T read() {
    final manager = UniStateProvider.of<T, S>(this);
    return manager;
  }

  /// Watches the state and rebuilds the widget when the state changes.
  T watch() {
    return UniStateProvider.of<T, S>(this);
  }
}
