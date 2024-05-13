import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/url_laoucher.dart';

import '../../../../app/theme.dart';

class AnyQuestionWidget extends StatefulWidget {
  final bool colors;

  const AnyQuestionWidget({Key key, this.colors, this.numberPhone})
      : super(key: key);
  final String numberPhone;
  @override
  State<AnyQuestionWidget> createState() => _AnyQuestionWidgetState();
}

class _AnyQuestionWidgetState extends State<AnyQuestionWidget> {
  GetStorage mailSave = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: kGlobal,
      child: InkWell(
        onTap: () {
          UrlLauncher.launchFeedBackEmail();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          // height: widget.colors == null ? 80 : 75,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 45,
                    width: 45,
                    child: Center(
                      child: Icon(
                        Icons.mail,
                        color: kGlobal,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CommonTextWidget(
                      text: 'Есть вопросы?',
                      fontWeight: FontWeight.w700,
                      size: 16,
                      fontFamily: 'Arial',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: CommonTextWidget(
                        text: 'tc@teklub.com',
                        size: 15,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
