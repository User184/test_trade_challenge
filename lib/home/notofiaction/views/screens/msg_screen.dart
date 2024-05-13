import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/home/notofiaction/views/widgets/msg_widget.dart';

import '../../../../app/theme.dart';
import '../../data/api_service_notification.dart';
import '../../models/msg_model.dart';

class MsgScreen extends StatefulWidget {
  const MsgScreen({
    Key key,
  }) : super(key: key);

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kGlobalBlack,
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //       setReadMsg();
        //     },
        //     icon: Icon(
        //       Icons.adaptive.arrow_back,
        //     ),
        //   ),
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   backgroundColor: kGlobalBlack,
        //   centerTitle: true,
        //   title: const CommonTextWidget(
        //     text: 'Уведомления',
        //     size: 20,
        //     fontWeight: FontWeight.w700,
        //   ),
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
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const CommonTextWidget(
                                text: 'Уведомления',
                                size: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff49536D),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4.5,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/images/cancel1.svg'),
                                  ),
                                ),
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: FutureBuilder<MsgModel>(
                              future:
                                  ApiServiceNotification.filesNotification(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  const Center(
                                    child: CommonTextWidget(
                                      text: 'Ошибка, попробуйте позже',
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: snapshot.data.data
                                          .map<Widget>(
                                            (e) => MsgWidget(
                                              title: e.title,
                                              content: e.content,
                                              time: e.createdAt,
                                              img: e.img,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: kGlobal,
                                      color: Colors.white,
                                    )),
                                  );
                                }
                                return const Center();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
