import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'pricemonitoring_widget.dart';

class PriceMonitoringCaruselWidget extends StatefulWidget {
  const PriceMonitoringCaruselWidget({Key key}) : super(key: key);

  @override
  State<PriceMonitoringCaruselWidget> createState() => _PriceMonitoringCaruselWidgetState();
}

class _PriceMonitoringCaruselWidgetState extends State<PriceMonitoringCaruselWidget> {
  final List<PriceMonitoringWidget> news = [
    const PriceMonitoringWidget(
      title: '8 этапов техники продаж: идеальный менеджер',
      image: 'assets/images/image2.png',
      date: '09.09.2021-21.09.2021',
      count: 100,
    ),
    const PriceMonitoringWidget(
      title: '8 этапов техники продаж: идеальный менеджер',
      image: 'assets/images/image2.png',
      date: '09.09.2021-21.09.2021',
      count: 100,
    ),
    const PriceMonitoringWidget(
      title: '8 этапов техники продаж: идеальный менеджер',
      // button: (){},
      count: 100,
      image: 'assets/images/image2.png',
      date: '09.09.2021-21.09.2021',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ценомониторинг',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: const Color(0xff49536D),
                  ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xff49536D),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.64,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
              disableCenter: false),
          items: news.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return PriceMonitoringWidget(
                  image: i.image,
                  button: i.button,
                  title: i.title,
                  date: i.date,
                  count: i.count,
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
