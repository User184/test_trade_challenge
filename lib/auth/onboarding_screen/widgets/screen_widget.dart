import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/constants.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/routes/route.dart' as route;

class ScreenWidget extends StatelessWidget {
  final String url;
  final String title;
  final String text;
  final bool last;
  final Function() onTap;
  const ScreenWidget(
      {Key key, this.url, this.text, this.title, this.last = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 60,
                width: 100,
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.1),
                    ),
                  ),
                  onPressed: onTap ??
                      () {
                        GetStorage strore = GetStorage();
                        Get.put(HomeController()).isShowOnBoardingScreen =
                            false;
                        if (strore.read('firstEnter') == true ||
                            strore.read('firstEnter') == null) {
                          Navigator.pushReplacementNamed(
                              context, route.pushAcceptScreen);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, route.homeScreen);
                        }
                      },
                  child: const CommonTextWidget(
                    text: 'Начать',
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 90.w,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: url,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: CommonTextWidget(
              text: title,
              size: 18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Linkify(
              linkStyle: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              onOpen: (link) {
                launch(link.url);
              },
              text: removeAllHtmlTags(text),
            ),
          ),
        ],
      ),
    );
  }
}
