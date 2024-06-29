import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tremors/components/background_map.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/main_panel/get_token.dart';
import 'package:tremors/main_panel/login_panel.dart';
import 'package:tremors/model/authenticator.dart';
import 'package:tremors/module.dart';

import 'foundation.dart';
import 'main_panel/layer_panel.dart';
import 'main_panel/realtime_panel.dart';
import 'main_panel/search_panel.dart';
import 'main_panel/settings_panel.dart';

typedef _WidgetBuilder = Widget Function();

TaskEither<TremorsException, GoRouter> router(
  AppModule appModule,
) =>
    TaskEither.Do(($) async {
      const backgroundMap = BackgroundMap();
      const topPanel = RealtimeTopPanel();

      doRedirect(BuildContext context, _) {
        return (context.read<AuthenticatorModel>().isLogged) ? null : '/login';
      }

      GoRoute routePage(
        String path,
        _WidgetBuilder builder, {
        bool isSecure = true,
      }) {
        final redirect = (isSecure) ? doRedirect : null;

        return GoRoute(
          path: path,
          pageBuilder: (_, __) => MaterialPage(child: builder()),
          redirect: redirect,
        );
      }

      Widget mainPage() {
        return Skeleton.onlyTopPanel(
            background: backgroundMap, topPanel: topPanel);
      }

      Widget Function() withTopPanel(Widget panel) {
        return () => Skeleton.withTopPanel(
              background: backgroundMap,
              topPanel: topPanel,
              mainPanel: panel,
            );
      }

      Widget Function() singlePanel(Widget panel) {
        return () =>
            Skeleton.singlePanel(background: backgroundMap, panel: panel);
      }

      return GoRouter(debugLogDiagnostics: true, routes: [
        routePage('/', mainPage),
        routePage('/layers', withTopPanel(const LayerPanel())),
        routePage('/search', withTopPanel(const SearchPanel())),
        routePage('/settings', withTopPanel(const SettingsPanel())),
        routePage('/realtime', singlePanel(const RealtimePanel())),
        routePage('/login', () => const LoginPanel(), isSecure: false),
        routePage(
          '/get-token/:provider/:token',
          () => GetTokenPanel(
            securityService: appModule.grpcModule.securityService,
          ),
          isSecure: false,
        )
      ]);
    });
