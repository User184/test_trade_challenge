import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../home/views/screens/pdf_faq_screen.dart';
import '../../models/actions_model.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key key, this.data}) : super(key: key);
  DataActions data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: kGlobalBlack,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 75),
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                            ),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: GestureDetector(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(41, 44, 49, 0.12)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xff8793B4),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: data.cover != null
                                ? Image.network(
                                    data.cover[0].url,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(
                                    height: 200,
                                    color: Colors.grey,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  text: data.title,
                                  fontWeight: FontWeight.w400,
                                  size: 18,
                                  color: const Color(0xff49536D),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Html(
                                  data: data.description,
                                  style: {
                                    "body": Style(
                                        margin: const EdgeInsets.all(0.0),
                                        fontSize: const FontSize(16),
                                        color: const Color(0xff8793B4))
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (data.promotionTerms != null)
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfViewer(
                                            url: data.promotionTerms[0].url,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: size.height * .09,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffF3F7FF),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color: kGlobal,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/pdf.svg',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * .15,
                                            ),
                                            const CommonTextWidget(
                                              text: 'Подробные условия',
                                              fontWeight: FontWeight.w400,
                                              size: 14,
                                              color: Color(0xff49536D),
                                            ),
                                            SizedBox(
                                              width: size.width * .15,
                                            ),
                                            SvgPicture.asset(
                                                'assets/images/download.svg')
                                          ],
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
              ),
            ],
          ),
        ));
  }
}
