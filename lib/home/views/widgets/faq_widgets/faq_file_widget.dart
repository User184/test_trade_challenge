import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/views/screens/pdf_faq_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme.dart';

class FaqFileWidget extends StatelessWidget {
  final String url;
  final String type;

  const FaqFileWidget({Key key, this.url, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewer(
                url: url,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: kGlobal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 45,
                  width: 45,
                  child: Center(
                    child: type == 'Offer'
                        ? Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          )
                        : SvgPicture.asset('assets/images/intrnet.svg'),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.9,
                child: CommonTextWidget(
                  text: type == 'Offer'
                      ? 'Правила акции'
                      : type == 'PrivacyPolicy'
                          ? 'Политика обработки персональных данных'
                          : type == 'ProcessingOfPD'
                              ? 'Пользовательское соглашение'
                              : 'Документ',
                  fontWeight: FontWeight.w400,
                  size: 14,
                  fontFamily: 'Arial',
                  color: const Color(0xff49536D),
                  overflow: TextOverflow.fade,
                ),
              ),
              const Spacer(),
              if (type == 'Offer')
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.file_download,
                    color: Color(0xff8793B4),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
