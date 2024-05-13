import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

class ChartWidget extends StatelessWidget {
  final double width;
  final int points;
  final int counts;
  final String type;
  const ChartWidget({Key key, this.width, this.points, this.counts, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextWidget(
          fontWeight: FontWeight.w700,
          size: 18,
          text: type,
          color: const Color(0xff49536D),
        ),
        const SizedBox(
          height: 30,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 63,
              bottom: 145,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xff3C6FE4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 140,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: CommonTextWidget(
                      fontWeight: FontWeight.w700,
                      size: 18,
                      text: '+$pointsб',
                      color: const Color(0xff3C6FE4),
                    ),
                  ),
                ),
                height: 50,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            Positioned(
              top: 70,
              left: 60,
              child: CommonTextWidget(
                fontWeight: FontWeight.w700,
                size: 22,
                text: '+$counts',
                color: const Color(0xff49536D),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
