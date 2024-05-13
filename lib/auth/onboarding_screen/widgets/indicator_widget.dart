import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class Indicator extends StatelessWidget {
  final mechanic;
  final int positionIndex;
  final int currentIndex;

  const Indicator(
      {Key key, this.currentIndex, this.positionIndex, this.mechanic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: positionIndex == currentIndex
            ? kGlobal
            : mechanic == null
                ? Colors.white
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
