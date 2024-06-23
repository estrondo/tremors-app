import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum _Type {
  asset;
}

class Svg extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final _Type _type;

  Svg.asset(
    this.source, {
    super.key,
    this.width,
    this.height,
  }) : _type = _Type.asset;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _Type.asset:
        return SvgPicture.asset(
          source,
          width: width,
          height: height,
        );
    }
  }
}
