import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'foundation.dart';
import 'main_panel/layer_panel.dart';
import 'main_panel/realtime_panel.dart';
import 'main_panel/search_panel.dart';
import 'main_panel/settings_panel.dart';

typedef _WidgetBuilder = Widget Function();

GoRouter router({required Widget backgroundMap, required Widget topPanel}) {
  GoRoute routePage(String path, _WidgetBuilder builder) {
    return GoRoute(
        path: path, pageBuilder: (_, __) => MaterialPage(child: builder()));
  }

  Widget mainPage() {
    return Skeleton.onlyTopPanel(background: backgroundMap, topPanel: topPanel);
  }

  Widget withTopPanel(Widget Function() mainPanelBuilder) {
    return Skeleton.withTopPanel(
      background: backgroundMap,
      topPanel: topPanel,
      mainPanel: mainPanelBuilder(),
    );
  }

  Widget onlyTopPanel(Widget panel) {
    return Skeleton.singlePanel(background: backgroundMap, panel: panel);
  }

  return GoRouter(debugLogDiagnostics: true, routes: [
    routePage('/', () => mainPage()),
    routePage('/layers', () => withTopPanel(() => const LayerPanel())),
    routePage('/search', () => withTopPanel(() => const SearchPanel())),
    routePage('/settings', () => withTopPanel(() => const SettingsPanel())),
    routePage('/realtime', () => onlyTopPanel(const RealtimePanel()))
  ]);
}
