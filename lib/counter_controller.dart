import 'package:control/control.dart';

/// Counter state for [CounterController]
typedef CounterState = ({int count, bool idle});

/// Observer for [Controller], react to changes in the any controller.
final class ControllerObserver implements IControllerObserver {
  const ControllerObserver();

  @override
  void onCreate(Controller controller) {
    print('Controller | ${controller.runtimeType} | Created');
  }

  @override
  void onDispose(Controller controller) {
    print('Controller | ${controller.runtimeType} | Disposed');
  }

  @override
  void onStateChanged<S extends Object>(
      StateController<S> controller, S prevState, S nextState) {
    print('StateController | ${controller.runtimeType} | $prevState -> $nextState');
  }

  @override
  void onError(Controller controller, Object error, StackTrace stackTrace) {
    print('Controller | ${controller.runtimeType} | $error');
    print(stackTrace);
  }
}

/// Counter controller
final class CounterController extends StateController<CounterState>
    with SequentialControllerHandler {
  CounterController({CounterState? initialState})
      : super(initialState: initialState ?? (idle: true, count: 0));

  void add(int value) => handle(() async {
    setState((idle: false, count: state.count));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    setState((idle: true, count: state.count + value));
  });

  void subtract(int value) => handle(() async {
    setState((idle: false, count: state.count));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    setState((idle: true, count: state.count - value));
  });

  void addThree(int value) => handle(() async {
    setState((idle: false, count: state.count));
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    setState((idle: true, count: state.count + value));
  });
}