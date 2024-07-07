import 'package:flutter/material.dart';
import 'package:tremors/svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Svg.asset(
      'images/logo.svg',
      height: 150,
      width: 150,
    );
  }
}
