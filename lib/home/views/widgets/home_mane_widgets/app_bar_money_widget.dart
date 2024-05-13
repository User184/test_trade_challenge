import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/home/controllers/home_controller.dart';

class AppBarMoneyWidget extends StatelessWidget {
  final PermissionModel4 permissionModel4;
  final int color;
  final bool color2;

  const AppBarMoneyWidget({
    Key key,
    this.color = 0xff49536D,
    this.permissionModel4,
    this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonTextWidget(
            text: '${permissionModel4.data.pointsBalance ?? '0'} б',
            fontWeight: FontWeight.w400,
            size: 20,
            fontFamily: 'Arial',
            color: color2 != null
                ? Colors.white
                : controller.currentHomePage == 'main' ||
                        controller.currentHomePage == 'catalog' ||
                        controller.currentHomePage == 'action' ||
                        controller.currentHomePage == 'gift_catalog'
                    ? Color(color)
                    : Colors.white,
          ),
        ],
      );
    });
  }
}
