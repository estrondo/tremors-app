import 'package:app/components/shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'icon_gallery.dart';

class Panel extends StatelessWidget {
  final int iconCode;
  final String title;
  final Widget _content;
  final Widget? _footer;

  const Panel(
      {super.key,
      required this.iconCode,
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
        height: 80,
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
      Icon(IconGallery.layers, size: 80, color: theme.colorScheme.primary),
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
              size: 30,
              color: theme.colorScheme.primary,
            )),
      )
    ];
  }

  Widget _divisor(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 10,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
