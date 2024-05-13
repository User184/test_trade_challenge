import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProductScreen extends StatefulWidget {
  final String title;
  final String text;
  final List imgUrl;
  final String sku;
  final String type;
  final int price;
  final List sliderImages;
  final List video;

  const ProductScreen({
    Key key,
    this.text,
    this.title,
    this.imgUrl,
    this.sku,
    this.price,
    this.type,
    this.sliderImages,
    this.video,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C6FE4),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        if (widget.imgUrl.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 50,right: 30),
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/ci.png',
                              ),
                              height: 200,
                            ),
                          ),
                        if (widget.imgUrl != null && widget.imgUrl.length == 1)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            child: SizedBox(
                              height: 220,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: widget.imgUrl.first.url,
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SizedBox(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        if (widget.imgUrl != null && widget.imgUrl.length > 1)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            child: SizedBox(
                              height: 220,
                              width: double.infinity,
                              child: CarouselSlider(
                                options: CarouselOptions(height: 220.0),
                                items: widget.imgUrl.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 35),
                                          child: CachedNetworkImage(
                                            imageUrl: i.url,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 60,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.imgUrl != null &&
                                      widget.imgUrl.length < 1
                                  ? 60
                                  : 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonTextWidget(
                                        text: widget.title,
                                        size: 22,
                                        color: const Color(0xff49536D),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CommonTextWidget(
                                        text: widget.sku,
                                        size: 14,
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.normal,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Html(
                                        data: widget.text,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300]),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(Icons.arrow_back_ios),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
