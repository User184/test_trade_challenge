import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

import '/app/routes/route.dart' as route;
import '../../../../auth/models/permission_model4.dart';
import '../../../controllers/home_controller.dart';

class MainBoxWidget extends StatefulWidget {
  final PermissionModel4 modelMe;
  const MainBoxWidget({Key key, this.modelMe}) : super(key: key);

  @override
  State<MainBoxWidget> createState() => _MainBoxWidgetState();
}

class _MainBoxWidgetState extends State<MainBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AppMetrica.reportEvent(
          'manualcheck',
        );
        Get.put(HomeController()).currentPageChange('action');
        Navigator.pushNamed(context, route.homeScreen);
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff3C6FE4).withOpacity(0.3),
                      blurRadius: 5.0,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/mainbox1.png',
                  // semanticsLabel: 'mainbox',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 50,
                  width: 50,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/scanicon.svg',
                      semanticsLabel: 'mainbox1',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CommonTextWidget(
                    text: 'Текущие акции',
                    fontWeight: FontWeight.w700,
                    size: 24,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
