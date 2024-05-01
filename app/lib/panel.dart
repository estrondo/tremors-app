import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
  final Widget _child;

  const BottomPanel({super.key, required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_child],
    );
  }
}

class TopPanel extends StatelessWidget {
  final Widget _child;

  const TopPanel({super.key, required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [_child],
    );
  }
}
