import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'foundation.dart';
import 'panel.dart';

typedef _PanelBuilder = Widget Function(BuildContext, GoRouterState);

typedef _PageBuilder = Page<Object> Function(BuildContext, GoRouterState);

GoRouter router(Widget backgroundMap) {
  const initialLocation = '/main';

  GoRoute route(String path, _PanelBuilder builder) {
    return GoRoute(path: path, builder: builder);
  }

  GoRoute routePage(String path, _PageBuilder builder) {
    return GoRoute(path: path, pageBuilder: builder);
  }

  _PanelBuilder bottomPanel(Widget Function() builder) {
    return (_, __) => BottomPanel(child: builder());
  }

  _PanelBuilder topPanel(Widget Function() builder) {
    return (_, __) => TopPanel(child: builder());
  }

  _PageBuilder bottomPage(Widget Function() builder) {
    return (_, __) => MaterialPage(child: BottomPanel(child: builder()));
  }

  _PageBuilder topPage(Widget Function() builder) {
    return (_, __) => MaterialPage(
            child: TopPanel(
          child: builder(),
        ));
  }

  Widget placeHolder(Color color) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => context.go('/main'),
        child: Container(
          color: color,
          child: const Placeholder(),
        ),
      );
    });
  }

  Widget mainPanel() {
    return SizedBox(
      height: 200,
      width: 100,
      child: placeHolder(Colors.greenAccent),
    );
  }

  final noContent = Container();

  return GoRouter(
      initialLocation: initialLocation,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
            builder: (_, state, child) {
              if (state.fullPath != '/main') {
                return Skeleton(background: backgroundMap, panel: child);
              } else {
                return Skeleton(background: backgroundMap);
              }
            },
            routes: [
              route('/main', (_, __) => noContent),
              routePage('/main/layers',
                  bottomPage(() => placeHolder(Colors.yellowAccent))),
              routePage('/main/search',
                  bottomPage(() => placeHolder(Colors.redAccent))),
              routePage('/main/settings',
                  bottomPage(() => placeHolder(Colors.deepPurple))),
              routePage('/main/realtime',
                  topPage(() => placeHolder(Colors.blueAccent))),
            ])
      ]);
}
