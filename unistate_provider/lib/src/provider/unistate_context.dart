import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'multi_unistate.dart';
import 'unistate.dart';

extension NotifierLookup on UniStateInheritedNotifier {
  T? _getNotifier<T extends Listenable>() {
    return notifiers.firstWhereOrNull((n) => n is T) as T?;
  }
}

extension UnistateExtension on BuildContext {
  T? read<T extends Listenable>() {
    final uniNotifier = findAncestorWidgetOfExactType<UniState<T>>();
    if (uniNotifier != null) {
      return uniNotifier.notifier;
    }

    final multiNotifier =
        findAncestorWidgetOfExactType<UniStateInheritedNotifier>();
    if (multiNotifier != null) {
      return multiNotifier._getNotifier<T>();
    }

    return null;
  }

  T? watch<T extends Listenable>() {
    final uniNotifier = dependOnInheritedWidgetOfExactType<UniState<T>>();
    if (uniNotifier != null) {
      return uniNotifier.notifier;
    }

    final multiNotifier =
        dependOnInheritedWidgetOfExactType<UniStateInheritedNotifier>();
    if (multiNotifier != null) {
      return multiNotifier._getNotifier<T>();
    }

    return null;
  }
}
