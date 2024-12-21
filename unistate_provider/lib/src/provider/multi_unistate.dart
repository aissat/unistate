import 'package:flutter/widgets.dart';

class MultiUniState extends StatefulWidget {
  final List<Listenable> notifiers;
  final Widget child;

  const MultiUniState({
    super.key,
    required this.notifiers,
    required this.child,
  });

  @override
  State<MultiUniState> createState() => _MultiUniStateState();
}

class UniStateInheritedNotifier extends InheritedWidget {
  final List<Listenable> notifiers;
  final int version;

  const UniStateInheritedNotifier({
    super.key,
    required this.notifiers,
    required this.version,
    required super.child,
  });

  @override
  bool updateShouldNotify(UniStateInheritedNotifier oldWidget) {
    return oldWidget.version != version;
  }

  static UniStateInheritedNotifier? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniStateInheritedNotifier>();
  }
}

class _MultiUniStateState extends State<MultiUniState> {
  final _notifiers = <Listenable>[];
  int _version = 0;

  @override
  Widget build(BuildContext context) {
    return UniStateInheritedNotifier(
      notifiers: _notifiers,
      version: _version,
      child: widget.child,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupListeners();
    // print('Listeners set up.');
  }

  @override
  void dispose() {
    _removeListeners();
    // print('Listeners removed.');
    super.dispose();
  }

  void _notifyDependents() {
    setState(() {
      _version++;
      // print('Version incremented to: $_version');
    });
  }

  void _removeListeners() {
    for (final notifier in _notifiers) {
      notifier.removeListener(_notifyDependents);
      // print('Removed listener for ${notifier.runtimeType}');
    }
  }

  void _setupListeners() {
    _notifiers.clear();
    _notifiers.addAll(widget.notifiers);
    for (final notifier in _notifiers) {
      notifier.addListener(_notifyDependents);
      // print('Added listener for ${notifier.runtimeType}');
    }
  }
}
