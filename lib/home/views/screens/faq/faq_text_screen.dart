import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

import '../../../../app/theme.dart';

class FaqTextScreen extends StatelessWidget {
  final String title;
  final String text;

  const FaqTextScreen({Key key, this.text, this.title}) : super(key: key);
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
    print(text);
    return Scaffold(
      backgroundColor: kGlobalBlack,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff3C6FE4),
      // ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextWidget(
                          text: title,
                          size: 24,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arial',
                          color: const Color(0xff49536D),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Linkify(
                          onOpen: (link) async {
                            if (!await launchUrl(Uri.parse(link.url))) {
                              throw Exception('Could not launch ${link.url}');
                            }
                          },
                          text: _parseHtmlString(text),
                          style: TextStyle(
                              color: Color(0xff8793B4),
                              fontSize: 16,
                              fontFamily: 'Abel'),
                          linkStyle: TextStyle(color: Colors.blue),
                        ),

                        //  Html(
                        //     onLinkTap:
                        //         (String url, RenderContext co, c, Element) {
                        //       print(url);
                        //       launch(url);
                        //     },
                        //     data: text,
                        //     style: {
                        //       "span": Style(
                        //           fontSize: const FontSize(16.0),
                        //           color: const Color(0xff8793B4),
                        //           fontFamily: 'Abel'),
                        //       "body": Style(
                        //           color: const Color(0xff8793B4),
                        //           fontSize: const FontSize(16.0),
                        //           fontFamily: 'Abel'),
                        //     }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
