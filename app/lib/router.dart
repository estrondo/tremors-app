import 'dart:math';

import 'package:app/components/shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'foundation.dart';
import 'main_panel/layer_panel.dart';
import 'main_panel/search_panel.dart';
import 'main_panel/settings_panel.dart';

typedef _WidgetBuilder = Widget Function();

GoRouter router({required Widget backgroundMap, required Widget topPanel}) {
  GoRoute routeWidget(String path, _WidgetBuilder builder) {
    return GoRoute(path: path, builder: (_, __) => builder());
  }

  GoRoute routePage(String path, _WidgetBuilder builder) {
    return GoRoute(
        path: path, pageBuilder: (_, __) => MaterialPage(child: builder()));
  }

  Widget onlyTopPanel() {
    return Skeleton.onlyTopPanel(background: backgroundMap, topPanel: topPanel);
  }

  Widget withTopPanel(Widget Function() mainPanelBuilder) {
    return Skeleton.withTopPanel(
      background: backgroundMap,
      topPanel: topPanel,
      mainPanel: mainPanelBuilder(),
    );
  }

  Widget placeHolder(Color color) {
    return ShadowBox(
        child: Container(
      color: color,
      height: 100,
    ));
  }

  Color nextColor() {
    final random = Random();
    return Color.fromARGB(
        0xff, random.nextInt(0xff), random.nextInt(0xff), random.nextInt(0xff));
  }

  return GoRouter(initialLocation: '/main', debugLogDiagnostics: true, routes: [
    routePage('/main', () => onlyTopPanel()),
    routePage('/main/layers', () => withTopPanel(() => const LayerPanel())),
    routePage('/main/search', () => withTopPanel(() => const SearchPanel())),
    routePage('/main/settings', () => withTopPanel(() => const SettingsPanel())),
  ]);
}
