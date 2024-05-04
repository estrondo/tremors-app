import 'dart:math';

import 'package:app/components/shadow_box.dart';
import 'package:app/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'foundation.dart';

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

  final c1 = nextColor();
  final c2 = nextColor();
  final c3 = nextColor();

  final Widget layerPanel = Builder(
      builder: (context) => Panel(
          iconCode: 0x61,
          title: AppLocalizations.of(context)!.layers_title,
          footer: placeHolder(c2),
          content: placeHolder(c1)));

  return GoRouter(initialLocation: '/main', debugLogDiagnostics: true, routes: [
    routePage('/main', () => onlyTopPanel()),
    routePage('/main/layers', () => withTopPanel(() => layerPanel)),
    routePage('/main/search', () => withTopPanel(() => placeHolder(c2))),
    routePage('/main/settings', () => withTopPanel(() => placeHolder(c3))),
  ]);
}
