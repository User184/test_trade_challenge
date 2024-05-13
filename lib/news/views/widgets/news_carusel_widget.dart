import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

import 'news_widget.dart';

class NewsCaruselWidget extends StatefulWidget {
  const NewsCaruselWidget({Key key}) : super(key: key);

  @override
  State<NewsCaruselWidget> createState() => _NewsCaruselWidgetState();
}

class _NewsCaruselWidgetState extends State<NewsCaruselWidget> {
  final List<NewsWidget> news = [
    const NewsWidget(
      likes: 123,
      watch: 455,
      image: 'assets/images/image.png',
      date: '12 ноя 2022',
      title:
          'Кто рано встает — dddddsss ssssss sss sssss sssss sdddтому кофейня кофе подаёт',
    ),
    const NewsWidget(
      likes: 123,
      watch: 455,
      image: 'assets/images/image.png',
      date: '12 ноя 2022',
      title: 'Кто рано встает — тому кофейня кофе подаёт',
    ),
    const NewsWidget(
      likes: 123,
      watch: 455,
      image: 'assets/images/image.png',
      date: '12 ноя 2022',
      title: 'Кто рано встает — тому кофейня кофе подаёт',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommonTextWidget(
              text: 'Новости',
              fontWeight: FontWeight.w700,
              size: 20,
              color: Color(0xff49536D),
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
              height: MediaQuery.of(context).size.width * 0.6,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
              disableCenter: false),
          items: news.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return NewsWidget(
                  image: i.image,
                  likes: i.likes,
                  watch: i.watch,
                  date: i.date,
                  title: i.title,
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
