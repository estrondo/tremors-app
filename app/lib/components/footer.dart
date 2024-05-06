import 'package:flutter/material.dart';

import '../collection.dart';
import 'form.dart';

class Footer extends StatelessWidget {
  static const _rowDivisor = SizedBox(width: 10);

  final List<Widget> _children;

  const Footer({super.key, required List<Widget> children})
      : _children = children;

  @override
  Widget build(BuildContext context) {
    final children = _children.mapInterpolated(
        (e) => Expanded(
              child: e,
            ),
        _rowDivisor);

    return SizedBox(
      height: rowHeight.toDouble(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...children],
      ),
    );
  }
}
