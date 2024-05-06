import 'package:app/collection.dart';
import 'package:flutter/material.dart';

import '../icon_gallery.dart';

typedef FieldEditorBuilder = Widget Function(BuildContext);
typedef StringBuilder = String Function(BuildContext);

class FieldData {
  final StringBuilder title;
  final Widget presentation;
  final FieldEditorBuilder? builder;

  FieldData(this.title, this.presentation, [this.builder]);
}

class Form extends StatelessWidget {
  final List<FieldData> _fields;
  final StringBuilder title;

  static const rowHeight = 30.0;

  const Form({super.key, required this.title, required List<FieldData> fields})
      : _fields = fields;

  @override
  Widget build(BuildContext context) {
    final divisor = Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        color: Theme.of(context).colorScheme.tertiary,
        height: 1);

    final children =
        _fields.mapInterpolated((e) => FormField(e, title), divisor);
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
              flex: 5,
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
  final FieldData field;
  final StringBuilder title;

  const FormField(this.field, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget row = Row(children: [
      Expanded(
        flex: 3,
        child: Text(
          field.title(context),
          style: theme.textTheme.labelMedium,
        ),
      ),
      Expanded(
        flex: 1,
        child: field.presentation,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: (field.builder != null)
            ? Icon(
                IconGallery.boldRightArrow,
                size: Form.rowHeight / 3,
                color: theme.colorScheme.tertiary,
              )
            : const SizedBox(
                width: Form.rowHeight / 3,
                height: Form.rowHeight / 3,
              ),
      )
    ]);

    if (field.builder != null) {
      row = GestureDetector(
        onTap: () => _edit(context),
        child: row,
      );
    }

    return (field.presentation is! SizedBox)
        ? SizedBox(height: Form.rowHeight, child: row)
        : row;
  }

  void _edit(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => FieldEditor(field, title)));
  }
}

class FieldEditor extends StatelessWidget {
  final FieldData field;
  final StringBuilder title;

  const FieldEditor(this.field, this.title, {super.key});

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
                  Text(field.title(context), style: theme.textTheme.displayLarge),
                  Text(
                    title(context),
                    style: theme.textTheme.displayMedium,
                  ),
                ])
              ])),
            ),
            spacer,
            Builder(builder: field.builder!)
          ])),
    );
  }
}
