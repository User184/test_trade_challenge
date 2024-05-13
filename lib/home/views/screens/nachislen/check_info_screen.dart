import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/home/views/widgets/nachislenie_widgets/info_check_widget.dart';

import '../../widgets/home_mane_widgets/any_quastion_widget.dart';

class CheckInfoScreen extends StatelessWidget {
  final String title;
  final String status;
  final String amount;
  final String createdAt;
  final String comment;

  const CheckInfoScreen({
    Key key,
    this.title,
    this.amount,
    this.comment,
    this.createdAt,
    this.status,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(status);
    return Scaffold(
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
                  padding: const EdgeInsets.only(top: 27),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: Center(
                          child: CommonTextWidget(
                            text: title,
                            size: 18,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                            color: const Color(0xff49536D),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatusWidget(
                        status: status,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (status != 'success' && status != 'accepted')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Center(
                            child: CommonTextWidget(
                              textAlign: TextAlign.center,
                              text: comment,
                              size: 18,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff8793B4),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: status == 'success' || status == 'accepted'
                                ? kGlobal
                                : Colors.grey[300],
                          ),
                          height: 225,
                          width: double.infinity,
                          child: Center(
                            child: CommonTextWidget(
                              color: status == 'success' || status == 'accepted'
                                  ? Colors.white
                                  : const Color(0xff49536D),
                              text: amount,
                              size: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Center(
                        child: CommonTextWidget(
                          text: createdAt,
                          size: 16,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff8793B4),
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                        child: AnyQuestionWidget(),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 10, top: MediaQuery.of(context).size.height * 0.08),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.close),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
