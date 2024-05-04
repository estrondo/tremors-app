import 'package:flutter/material.dart';

typedef FormEntry = (String, Widget);

class Form extends StatelessWidget {
  final List<FormEntry> _entries;

  static const rowHeight = 25.0;
  static const _rowDivisor = SizedBox(height: 10);

  const Form({super.key, required List<FormEntry> entries})
      : _entries = entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: _rows(Theme.of(context)));
  }

  List<Widget> _rows(ThemeData theme) {
    final iterator = _entries.iterator;
    final result = <Widget>[];
    final l = _entries.length - 1;

    for (var i = 0; iterator.moveNext(); i++) {
      final e = iterator.current;
      result.add(SizedBox(
        height: rowHeight,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(e.$1, style: theme.textTheme.titleMedium),
            ),
            Expanded(
              flex: 2,
              child: e.$2,
            )
          ],
        ),
      ));

      if (i < l) {
        result.add(_rowDivisor);
      }
    }

    return result;
  }
}
