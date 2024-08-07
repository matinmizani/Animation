import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CenteredSvgIcon extends StatelessWidget {
  const CenteredSvgIcon({super.key, required this.assets, required this.color});

  final String assets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isSvg = assets.endsWith(".svg");
    final factor =isSvg? 0.3:0.08;
    return FractionallySizedBox(
      widthFactor: factor,
      heightFactor: factor,
      child: isSvg
          ? SvgPicture.asset(
              assets,
              color: color,
            )
          : Text(
              assets.substring(0, 1),
              style: TextStyle(color: color),
            ),
    );
  }
}
