import 'package:app/components/shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'icon_gallery.dart';

class Panel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget _content;
  final Widget? _footer;

  static const headerHeight = 45.0;

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
    final List<Widget> bottom;
    if (_footer != null) {
      bottom = [_divisor(context), _footer];
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
      _divisor(context),
      _content,
      ...bottom
    ]));
  }

  List<Widget> _titleWidget(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(icon, size: headerHeight, color: theme.colorScheme.primary),
      ),
      Expanded(
          child: Text(
        title,
        style: theme.textTheme.titleLarge,
      )),
    ];
  }

  List<Widget> _closeWidget(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            onTap: () => context.go('/main'),
            child: Icon(
              IconGallery.close,
              size: headerHeight / 2,
              color: theme.colorScheme.primary,
            )),
      )
    ];
  }

  Widget _divisor(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 3,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      color: theme.colorScheme.secondaryContainer,
    );
  }
}
