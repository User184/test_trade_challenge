import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

import '/app/routes/route.dart' as route;

class HandCheckAddScreenCompl extends StatelessWidget {
  final String result;
  const HandCheckAddScreenCompl({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C6FE4),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300]),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.highlight_off),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  result == 'false'
                                      ? SvgPicture.asset(
                                          'assets/images/bad1.svg',
                                          semanticsLabel: 'bad',
                                          fit: BoxFit.fitWidth,
                                        )
                                      : result == 'true'
                                          ? SvgPicture.asset(
                                              'assets/images/good1.svg',
                                              semanticsLabel: 'good',
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Container(),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  result == 'false'
                                      ? const CommonTextWidget(
                                          color: Color(0xff49536D),
                                          text: 'Чек уже есть в базе',
                                          size: 20,
                                          textAlign: TextAlign.center,
                                        )
                                      : result == 'true'
                                          ? const CommonTextWidget(
                                              color: Color(0xff49536D),
                                              text:
                                                  'Спасибо!\nЧек отправлен на проверку',
                                              size: 20,
                                              textAlign: TextAlign.center,
                                            )
                                          : Container(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                              top: 5,
                              right: 25,
                            ),
                            child: Material(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: const Color(0xff3C6FE4),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pushReplacementNamed(
                                      context, route.homeScreen);
                                },
                                child: SizedBox(
                                  height: 70,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        CommonTextWidget(
                                          text: 'На главную',
                                          fontWeight: FontWeight.w700,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
