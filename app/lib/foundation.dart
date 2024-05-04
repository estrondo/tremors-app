import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:go_router/go_router.dart';

import 'components/shadow_box.dart';
import 'icon_gallery.dart';

/// The application skeleton.
class Skeleton extends StatelessWidget {
  final Widget _background;
  final List<Widget> children;

  Skeleton.withTopPanel(
      {super.key,
      required Widget background,
      required Widget topPanel,
      required Widget mainPanel})
      : _background = background,
        children = [
          topPanel,
          _skeletonTransparentFiller(),
          mainPanel,
          _skeletonDivisor(),
          _createNavBar()
        ];

  Skeleton.onlyTopPanel(
      {super.key, required Widget background, required Widget topPanel})
      : _background = background,
        children = [topPanel, _skeletonTransparentFiller(), _createNavBar()];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _background,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: children,
          ),
        ),
      )
    ]);
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  static const height = 40.0;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final theme = Theme.of(context);

    return ShadowBox(
      child: Row(
        children: [
          _button(IconGallery.layers, '/main/layers', context, state, theme),
          _button(IconGallery.search, '/main/search', context, state, theme),
          _button(
              IconGallery.settings, '/main/settings', context, state, theme),
          _divisor(context),
          _logo()
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

  Widget _divisor(BuildContext context) {
    return Container(
      width: 3,
      height: height,
      color: Theme.of(context).colorScheme.secondaryContainer,
    );
  }

  Widget _logo() {
    return const Expanded(
      child: Image(
        width: height,
        height: height,
        image: Svg('images/logo.svg'),
      ),
    );
  }
}

class RealtimePanel extends StatelessWidget {
  const RealtimePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: Row(
        children: [
          Text(
            'Realtime',
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}

Widget _createNavBar() {
  return const NavBar();
}

Widget _skeletonTransparentFiller() {
  return Expanded(child: Container());
}

Widget _skeletonDivisor() {
  return const SizedBox(
    height: 5,
  );
}
