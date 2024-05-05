import 'package:app/collection.dart';
import 'package:flutter/material.dart';

typedef FormEntry = (String, Widget);

class Form extends StatelessWidget {
  final List<FormEntry> _entries;

  static const rowHeight = 30.0;
  static const _rowDivisor = SizedBox(height: 10);

  const Form({super.key, required List<FormEntry> entries})
      : _entries = entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: _rows(Theme.of(context)));
  }

  List<Widget> _rows(ThemeData theme) {
    return _entries.mapInterpolated(
        (e) => SizedBox(
              height: (e.$2 is! SizedBox) ? rowHeight : null,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(e.$1, style: theme.textTheme.labelMedium),
                  ),
                  Expanded(
                    flex: 1,
                    child: e.$2,
                  )
                ],
              ),
            ),
        _rowDivisor);
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
