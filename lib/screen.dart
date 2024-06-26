import 'package:control/control.dart';
import 'package:flutter/material.dart';

import 'counter_controller.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        floatingActionButton: const CounterScreen$Buttons(),
        body: const SafeArea(
          child: Center(
            child: CounterScreen$Text(),
          ),
        ),
      );
}

class CounterScreen$Text extends StatelessWidget {
  const CounterScreen$Text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineMedium;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Count: ',
          style: style,
        ),
        SizedBox.square(
          dimension: 64,
          child: Center(
            // Receive CounterController from the element tree
            // and rebuild the widget when the state changes.
            child: StateConsumer<CounterController, CounterState>(
              buildWhen: (previous, current) =>
                  previous.count != current.count ||
                  previous.idle != current.idle,
              builder: (context, state, _) {
                final text = state.count.toString();
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  child: state.idle
                      ? Text(text, style: style, overflow: TextOverflow.fade)
                      : const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CounterScreen$Buttons extends StatelessWidget {
  const CounterScreen$Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        // Transform [StateController] in to [ValueListenable]
        valueListenable: context
            .controllerOf<CounterController>()
            .select((state) => state.idle),
        builder: (context, idle, _) => IgnorePointer(
          ignoring: !idle,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 350),
            opacity: idle ? 1 : .25,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton(
                  key: ValueKey('add#${idle ? 'enabled' : 'disabled'}'),
                  onPressed: idle
                      ? () => context.controllerOf<CounterController>().add(1)
                      : null,
                  child: const Text('+1'),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  key: ValueKey('subtract#${idle ? 'enabled' : 'disabled'}'),
                  onPressed: idle
                      ? () =>
                          context.controllerOf<CounterController>().subtract(1)
                      : null,
                  child: const Text('-1'),
                ),
                FloatingActionButton(
                  key: ValueKey('addThree#${idle ? 'enabled' : 'disabled'}'),
                  onPressed: idle
                      ? () =>
                          context.controllerOf<CounterController>().addThree(3)
                      : null,
                  child: const Text('+3'),
                ),
              ],
            ),
          ),
        ),
      );
}
