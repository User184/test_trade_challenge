import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double size;
  final double height;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool underline;

  const CommonTextWidget({
    Key key,
    this.text,
    this.size = 14,
    this.fontWeight,
    this.color,
    this.height,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontFamily ='Arial',
    this.underline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: fontWeight,
          fontSize: size.sp - 5,
          height: height,
          decoration: underline == null
              ? TextDecoration.none
              : TextDecoration.underline,
          color: color,
          fontFamily: fontFamily),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
