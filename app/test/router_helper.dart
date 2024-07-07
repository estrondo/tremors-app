import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// based on https://github.com/flutter/packages/blob/main/packages/go_router/test/test_helpers.dart
Future<GoRouter> createGoRouter(
  WidgetTester tester,
  List<GoRoute> routes,
) async {
  final goRouter = GoRouter(routes: routes);

  addTearDown(() => goRouter.dispose());

  await tester.pumpWidget(MaterialApp.router(
    localizationsDelegates: const [AppLocalizations.delegate],
    routerConfig: goRouter,
  ));

  return goRouter;
}
