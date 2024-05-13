import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/controllers/user_controller.dart';

class AddPhotoWidget3 extends StatelessWidget {
  const AddPhotoWidget3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Material(
            child: InkWell(
              onTap: () {
                controller.getPhoto3();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonTextWidget(
                      text: 'Фото лицевой стороны',
                      size: 16,
                      color: Color(0xff3C6FE4),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (controller.selectedImageMain2 != null)
                      GestureDetector(
                        onTap: () {
                          controller.clearImages3();
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child:
                                      Image.file(controller.selectedImageMain2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (controller.selectedImageMain2 == null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.local_see,
                            color: Color(0xff3C6FE4),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CommonTextWidget(
                                text: 'Загрузить',
                                size: 18,
                                color: Color(0xff3C6FE4),
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 5),
                              CommonTextWidget(
                                text: 'Не более 2 мб',
                                size: 16,
                                color: Color(0xff8793B4),
                              ),
                            ],
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AddPhotoWidget4 extends StatelessWidget {
  const AddPhotoWidget4({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Material(
            child: InkWell(
              onTap: () {
                controller.getPhoto4();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonTextWidget(
                      text: 'Фото регистрации',
                      size: 16,
                      color: Color(0xff3C6FE4),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (controller.selectedImageAddress2 != null)
                      GestureDetector(
                        onTap: () {
                          controller.clearImages4();
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.file(
                                      controller.selectedImageAddress2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (controller.selectedImageAddress2 == null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.local_see,
                            color: Color(0xff3C6FE4),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CommonTextWidget(
                                text: 'Загрузить',
                                size: 18,
                                color: Color(0xff3C6FE4),
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 5),
                              CommonTextWidget(
                                text: 'Не более 2 мб',
                                size: 16,
                                color: Color(0xff8793B4),
                              ),
                            ],
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
