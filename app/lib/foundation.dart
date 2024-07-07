import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tremors/svg.dart';

import 'components/realtime_clock.dart';
import 'components/shadow_box.dart';
import 'icon_gallery.dart';

/// The application skeleton.
class Skeleton extends StatelessWidget {
  final Widget _background;
  final List<Widget> children;

  static const padding = 5.0;

  static const _divisor = SizedBox(
    height: padding,
  );

  static const _filler = Spacer();

  static const _navBar = NavBar();

  Skeleton.withTopPanel(
      {super.key,
      required Widget background,
      required Widget topPanel,
      required Widget mainPanel})
      : _background = background,
        children = [
          topPanel,
          _divisor,
          Expanded(child: mainPanel),
          _divisor,
          _navBar
        ];

  Skeleton.onlyTopPanel(
      {super.key, required Widget background, required Widget topPanel})
      : _background = background,
        children = [topPanel, _filler, _navBar];

  Skeleton.singlePanel({super.key, required background, required Widget panel})
      : _background = background,
        children = [Expanded(child: panel), _divisor, _navBar];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _background,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: children,
          ),
        ),
      ),
    ]);
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  static const height = 25.0;

  static final _logo = Expanded(
    child: Svg.asset(
      'images/logo.svg',
      width: height,
      height: height,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final theme = Theme.of(context);

    final divisor = Container(
      width: 3,
      height: height,
      color: theme.colorScheme.secondaryContainer,
    );

    return ShadowBox(
      child: Row(
        children: [
          _button(IconGallery.layers, '/layers', context, state, theme),
          _button(IconGallery.search, '/search', context, state, theme),
          _button(IconGallery.settings, '/settings', context, state, theme),
          divisor,
          _logo
        ],
      ),
    );
  }

  Widget _button(IconData iconData, String path, BuildContext context,
      GoRouterState state, ThemeData theme) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(path),
        child: Icon(
          iconData,
          size: height,
          color: state.fullPath == path
              ? theme.colorScheme.inversePrimary
              : theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class RealtimeTopPanel extends StatelessWidget {
  const RealtimeTopPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: GestureDetector(
          onTap: () {
            context.go('/realtime');
          },
          child: const RealtimeClock()),
    );
  }
}

class FollowUpPanel extends StatelessWidget {
  final Widget header;
  final Widget body;

  const FollowUpPanel({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surfaceContainer,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(child: header),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3,
              child: body,
            )
          ],
        ),
      ),
    );
  }
}
