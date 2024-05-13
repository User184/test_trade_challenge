import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/home/notofiaction/data/api_service_notification.dart';
import 'package:teklub/home/notofiaction/views/screens/open_msg_screen.dart';

class MsgWidget extends StatelessWidget {
  final String type;
  final String title;
  final String content;
  final String img;
  final String time;

  const MsgWidget(
      {Key key, this.type, this.title, this.content, this.img, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setReadMsg() async {
      await ApiServiceNotification.readStatus();
      // print(result);
    }

    var controller = Get.put(HomeController());

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedstring1 = content.replaceAll(exp, ' ');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            print('after${controller.msgList.value}');
            controller.msgList.value = controller.msgList.value
                .where((element) => element.title != title)
                .toList();
            if (controller.msgList.value.isEmpty) setReadMsg();
            print(controller.msgList.value);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OpenMsgScreen(
                  title: title,
                  text: content,
                  imgUrl: img,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 35,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff13971E),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .56,
                            child: CommonTextWidget(
                              text: ' $title',
                              size: 16,
                              fontFamily: 'Arial',
                              color: const Color(0xff49536D),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CommonTextWidget(
                            text: time,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: Html(
                              data: parsedstring1,
                              style: {
                                "body": Style(
                                    fontFamily: 'Arial',
                                    maxLines: 3,
                                    color: const Color(0xff8793B4),
                                    fontSize: const FontSize(14))
                              },
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                            color: Color(0xff8793B4),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
