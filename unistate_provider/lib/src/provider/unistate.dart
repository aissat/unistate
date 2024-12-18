import 'package:flutter/widgets.dart';

class UniState<T extends Listenable> extends InheritedNotifier<T> {
  const UniState({
    super.key,
    required super.notifier,
    required super.child,
  });

  static UniState<T>? of<T extends Listenable>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UniState<T>>();
  }
}
