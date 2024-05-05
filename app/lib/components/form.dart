import 'package:app/collection.dart';
import 'package:flutter/material.dart';

import '../icon_gallery.dart';

class FormEntry {
  final String title;
  final Widget presentation;
  final Widget? editor;

  FormEntry(this.title, this.presentation, [this.editor]);
}

class Form extends StatelessWidget {
  final List<FormEntry> _entries;
  final String title;

  static const rowHeight = 30.0;
  const Form({super.key, required this.title, required List<FormEntry> entries})
      : _entries = entries;

  @override
  Widget build(BuildContext context) {
    final divisor = Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        color: Theme.of(context).colorScheme.tertiary,
        height: 1);

    final children =
        _entries.mapInterpolated((e) => FormField(e, title), divisor);
    return Column(children: children);
  }
}

class FormFooter extends StatelessWidget {
  static const _rowHeight = 40.0;
  static const _rowDivisor = SizedBox(width: 10);

  final List<Widget> _children;

  const FormFooter({super.key, required List<Widget> children})
      : _children = children;

  @override
  Widget build(BuildContext context) {
    final children = _children.mapInterpolated(
        (e) => Expanded(
              flex: 4,
              child: e,
            ),
        _rowDivisor);

    return SizedBox(
      height: _rowHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: _children.length, child: Container()),
          ...children
        ],
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final FormEntry entry;
  final String title;

  const FormField(this.entry, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget row = Row(children: [
      Expanded(
        flex: 3,
        child: Text(
          entry.title,
          style: theme.textTheme.labelMedium,
        ),
      ),
      Expanded(
        flex: 1,
        child: entry.presentation,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: (entry.editor != null)
            ? Icon(
                IconGallery.regularRightArrow,
                size: Form.rowHeight / 3,
                color: theme.colorScheme.tertiary,
              )
            : const SizedBox(
                width: Form.rowHeight / 3,
                height: Form.rowHeight / 3,
              ),
      )
    ]);

    if (entry.editor != null) {
      row = GestureDetector(
        onTap: () => _edit(context),
        child: row,
      );
    }

    return (entry.presentation is! SizedBox)
        ? SizedBox(height: Form.rowHeight, child: row)
        : row;
  }

  void _edit(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => EditorPage(entry, title)));
  }
}

class EditorPage extends StatelessWidget {
  final FormEntry entry;
  final String title;

  const EditorPage(this.entry, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const spacer = SizedBox(
      height: 10,
    );

    return SafeArea(
      child: Container(
          color: theme.colorScheme.background,
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            spacer,
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                  child: Row(children: [
                Icon(
                  IconGallery.regularLeftArrow,
                  size: 30,
                  color: theme.colorScheme.tertiary,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(entry.title, style: theme.textTheme.titleLarge),
                  Text(
                    title,
                    style: theme.textTheme.titleSmall,
                  ),
                ])
              ])),
            ),
            spacer,
            entry.editor!
          ])),
    );
  }
}
