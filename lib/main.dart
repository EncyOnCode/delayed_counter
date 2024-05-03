import 'dart:async';

import 'package:control/control.dart';
import 'package:delayed_counter/screen.dart';
import 'package:flutter/material.dart';
import 'counter_controller.dart';

void main() => runZonedGuarded<Future<void>>(
      () async {
    // Setup controller observer
    Controller.observer = const ControllerObserver();
    runApp(const App());
  },
      (error, stackTrace) => print('Top level exception: $error'),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'StateController example',
      theme: ThemeData.dark(),
      home: const CounterScreen(),
      builder: (context, child) =>
      // Create and inject the controller into the element tree.
      ControllerScope<CounterController>(
        CounterController.new,
        child: child,
      ));
}