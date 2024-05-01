import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'shadow_box.dart';

/// The application skeleton.
class Skeleton extends StatelessWidget {
  final Widget _background;
  final Widget? _panel;

  const Skeleton({super.key, required Widget background, Widget? panel})
      : _background = background,
        _panel = panel;

  @override
  Widget build(BuildContext context) {
    const navBar = NavBar();

    final List<Widget> children;
    if (_panel != null) {
      children = [
        _divisor(),
        TransparentPointer(child: _panel),
        _divisor(),
        navBar
      ];
    } else {
      children = [navBar];
    }

    return Stack(
      children: [
        _background,
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: children,
          ),
        )
      ],
    );
  }

  Widget _divisor() {
    return const SizedBox(
      height: 10,
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final theme = Theme.of(context);

    return ShadowBox(
      child: Row(
        children: [
          _button(0x61, '/main/layers', context, state, theme),
          _button(0x62, '/main/search', context, state, theme),
          _button(0x63, '/main/settings', context, state, theme),
          _divisor(context),
          _logo()
        ],
      ),
    );
  }

  Widget _button(int codePoint, String path, BuildContext context,
      GoRouterState state, ThemeData theme) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(path),
        child: Icon(
          IconData(codePoint, fontFamily: 'icon-gallery'),
          size: 30,
          color:
              state.fullPath == path ? theme.colorScheme.inversePrimary : theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _divisor(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 3,
          height: 40,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }

  Widget _logo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          'images/logo-256x256.png',
          height: 60,
          cacheHeight: 60,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
