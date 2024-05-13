import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/controllers/home_controller.dart';

import '../../../../app/theme.dart';

class UserElementWidget extends StatefulWidget {
  final String name;

  const UserElementWidget({Key key, this.name}) : super(key: key);

  @override
  State<UserElementWidget> createState() => _UserElementWidgetState();
}

class _UserElementWidgetState extends State<UserElementWidget> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Obx(() {
          //   return Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(12),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.black.withOpacity(0.1),
          //             blurRadius: 3.0,
          //             offset: const Offset(0, 5)),
          //       ],
          //     ),
          //     height: 60,
          //     width: 60,
          //     child: homeController.avatar.value == null
          //         ? const Center(
          //             child: Icon(
          //               Icons.account_circle_outlined,
          //               color: kGlobal,
          //               size: 40,
          //             ),
          //           )
          //         : ClipRRect(
          //             borderRadius: BorderRadius.circular(10),
          //             child: Image.memory(homeController.avatar.value),
          //           ),
          //   );
          // }),

          // const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonTextWidget(
                text: 'Привет,',
                size: 16,
                color: kTextColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CommonTextWidget(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: widget.name ?? '',
                  size: 24,
                  color: const Color(0xff49536D),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
