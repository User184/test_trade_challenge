import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../../../home/views/screens/home_screen.dart';
import '/app/routes/route.dart' as route;

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/common/components/snack_bar.dart';
import '../../../app/user/data/api_setting_user.dart';
import '../../controller/reg_form_controller.dart';
import 'box_container_widget.dart';

class SpecsScreen extends StatelessWidget {
  SpecsScreen({Key key, this.pageName}) : super(key: key);

  RegFormController regFormController = Get.find();
  PageName pageName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<RegFormController>(
        init: RegFormController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color(0xff3C6FE4),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                  ),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[300]),
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
                                SizedBox(
                                  width: size.width / 17,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 60),
                                  child: CommonTextWidget(
                                    text: 'Специализация',
                                    fontWeight: FontWeight.w500,
                                    size: 20,
                                    color: Color(0xff8793B4),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: size.height * .7,
                              child: ListView.separated(
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    controller.checkBox(index);
                                  },
                                  child: BoxContainerWidget(
                                    text:
                                        regFormController.dataSpecs[index].name,
                                    isSelect: regFormController
                                        .dataSpecs[index].select,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 1,
                                ),
                                itemCount: regFormController.dataSpecs.length,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25,
                                  bottom: size.height * 0.05,
                                  right: 25),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                color: const Color(0xff3C6FE4),
                                child: InkWell(
                                  onTap: () async {
                                    print(pageName);
                                    if (pageName == PageName.Home ||
                                        pageName == PageName.Profile) {
                                      final result =
                                          await ApiSettingUser.setSpecs(
                                              controller.selectedId);
                                      print(result);
                                      if (result == 'OK') {
                                        if (pageName == PageName.Home) {
                                          Navigator.pushReplacementNamed(
                                              context, route.homeScreen);
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      }
                                    } else {
                                      Navigator.pop(context);
                                    }
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
                                            text: 'Сохранить',
                                            fontWeight: FontWeight.w700,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                          // controller.loading == true
                                          //     ? const SizedBox(
                                          //   width: 15,
                                          //   height: 15,
                                          //   child:
                                          //   CircularProgressIndicator(
                                          //       backgroundColor:
                                          //       Colors
                                          //           .white),
                                          // )
                                          //     :
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
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
