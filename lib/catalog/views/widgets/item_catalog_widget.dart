import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/catalog/views/screens/product_screen.dart';

class ItemCatalogWidget extends StatelessWidget {
  final String type;
  final List imageUrl;
  final String title;
  final String sku;
  final int price;
  final String text;
  final List sliderImages;
  final List video;

  const ItemCatalogWidget(
      {Key key,
      this.type,
      this.imageUrl,
      this.title,
      this.sku,
      this.price,
      this.text,
      this.sliderImages,
      this.video})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              imgUrl: imageUrl,
              title: title,
              sku: sku,
              price: price,
              type: type,
              text: text,
              sliderImages: sliderImages,
              video: video,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.blue.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CachedNetworkImage(
                        imageUrl:imageUrl.isEmpty ? '' : imageUrl.first.url,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SizedBox(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                             Padding(
                               padding: const EdgeInsets.only(right: 7,top: 10,bottom: 10),
                               child: Image.asset('assets/images/ci.png'),
                             ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //         color: Color(0xff3C6FE4),
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(12),
                  //         ),
                  //       ),
                  //       width: 75,
                  //       height: 25,
                  //       child: Center(
                  //         child: CommonTextWidget(
                  //           text: type == 'cashback' ? 'кэшбэк' : 'продажи',
                  //           fontWeight: FontWeight.w600,
                  //           size: 14,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CommonTextWidget(
                  text: title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: const Color(0xff8793B4),
                  size: 16,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CommonTextWidget(
                  text: sku ?? '',
                  color: const Color(0xff8793B4),
                  size: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: CommonTextWidget(
                  text: '\u20BD $price',
                  color: const Color(0xff000000),
                  size: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
