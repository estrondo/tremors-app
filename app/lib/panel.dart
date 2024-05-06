import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/shadow_box.dart';
import 'icon_gallery.dart';

class Panel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget _content;
  final Widget? _footer;

  static const headerHeight = 40.0;

  const Panel(
      {super.key,
      required this.icon,
      required this.title,
      required Widget content,
      Widget? footer})
      : _content = content,
        _footer = footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final divisor = Container(
      height: 3,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      color: theme.colorScheme.secondaryContainer,
    );

    final List<Widget> bottom;
    if (_footer != null) {
      bottom = [divisor, _footer];
    } else {
      bottom = [];
    }

    return ShadowBox(
        child: Column(children: [
      SizedBox(
        height: headerHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [..._titleWidget(context), ..._closeWidget(context)],
        ),
      ),
      divisor,
      Expanded(child: SingleChildScrollView(child: _content)),
      ...bottom
    ]));
  }

  List<Widget> _titleWidget(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(icon, size: headerHeight, color: theme.colorScheme.primary),
      ),
      Expanded(
          child: Text(
        title,
        style: theme.textTheme.displayLarge,
      )),
    ];
  }

  List<Widget> _closeWidget(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            onTap: () => context.go('/'),
            child: Icon(
              IconGallery.close,
              size: headerHeight / 2,
              color: theme.colorScheme.primary,
            )),
      )
    ];
  }
}
