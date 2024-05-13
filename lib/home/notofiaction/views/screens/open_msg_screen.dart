import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';
import '../../../../app/theme.dart';

class OpenMsgScreen extends StatelessWidget {
  final String title;
  final String text;
  final String imgUrl;

  const OpenMsgScreen({
    Key key,
    this.text,
    this.title,
    this.imgUrl,
  }) : super(key: key);

  String convertStringToLink(String textData) {
    //
    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(textData);
    List<String> urls = urlMatches
        .map((urlMatch) => textData.substring(urlMatch.start, urlMatch.end))
        .toList();
    List linksString = [];
    urls.forEach((String linkText) {
      linksString.add(linkText);
    });

    if (linksString.length > 0) {
      linksString.forEach((linkTextData) {
        textData = textData.replaceAll(
            linkTextData,
            '<a href="' +
                linkTextData +
                '" target="_blank">' +
                linkTextData +
                '</a>');
      });
    }
    return textData;
  }

  @override
  Widget build(BuildContext context) {
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
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            imgUrl == null
                                ? Container(
                                    height: 60,
                                  )
                                : SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: title,
                                    size: 22,
                                    color: const Color(0xff49536D),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Linkify(
                                    onOpen: (link) async {
                                      if (!await launchUrl(
                                          Uri.parse(link.url))) {
                                        throw Exception(
                                            'Could not launch ${link.url}');
                                      }
                                    },
                                    text: _parseHtmlString(text),
                                    style: TextStyle(
                                        color: Color(0xff8793B4),
                                        fontSize: 18,
                                        fontFamily: 'Abel'),
                                    linkStyle: TextStyle(color: Colors.blue),
                                  ),
                                  // CommonTextWidget(
                                  //   text: text,
                                  //   size: 18,
                                  //   color: const Color(0xff8793B4),
                                  //   fontWeight: FontWeight.normal,
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
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
          ),
        ],
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}
