import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

mixin GoRouterAndWidgetTester {
  GoRouter get goRouter;

  WidgetTester get tester;

  Future<void> goAndPump(String location, [Duration? duration]) async {
    goRouter.go(location);
    await tester.pump();
    return duration == null ? tester.pump() : tester.pump(duration);
  }

  Future<int> goAndPumpAndSettle(String location, [Duration? duration]) async {
    goRouter.go(location);
    await tester.pump();
    return (duration == null)
        ? tester.pumpAndSettle()
        : tester.pumpAndSettle(duration);
  }

  Future<T?> runAsync<T>(Future<T> Function() callback) =>
      tester.runAsync(callback);

  Future<int?> asyncGoAndPumpAndSettle(String location) {
    goRouter.go(location);
    return tester.runAsync(tester.pumpAndSettle);
  }
}
