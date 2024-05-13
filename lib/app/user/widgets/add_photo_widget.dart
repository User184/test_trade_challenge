import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/controllers/user_controller.dart';

class AddPhotoWidget1 extends StatelessWidget {
  final bool status;
  final String imgUrl;
  const AddPhotoWidget1({Key key, this.status, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Material(
        child: InkWell(
          onTap: () {
            if (imgUrl != null) {
              return;
            } else {
              controller.getPhoto();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
            child: imgUrl != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                      imageUrl: imgUrl,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 60,
                      ),
                    ),
                  )
                : Column(
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
                      if (controller.selectedImageMain != null)
                        GestureDetector(
                          onTap: () {
                            controller.clearImages1();
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
                                        controller.selectedImageMain),
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
                      if (controller.selectedImageMain == null)
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

class AddPhotoWidget2 extends StatelessWidget {
  final bool status;
  final String imgUrl;
  const AddPhotoWidget2({
    Key key,
    this.status,
    this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Material(
        child: InkWell(
          onTap: () {
            if (imgUrl != null) {
              return;
            } else {
              controller.getPhoto2();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
            child: imgUrl != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                      imageUrl: imgUrl,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 60,
                      ),
                    ),
                  )
                : Column(
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
                      if (controller.selectedImageAddress != null)
                        GestureDetector(
                          onTap: () {
                            controller.clearImages2();
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
                                        controller.selectedImageAddress),
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
                      if (controller.selectedImageAddress == null)
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
