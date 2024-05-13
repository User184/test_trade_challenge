import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/app/common/components/url_laoucher.dart';
import 'package:teklub/auth/controller/auth_controller.dart';
import 'package:teklub/auth/models/promo_check_model.dart';

import '../../../app/theme.dart';

class PromoCodeWidget extends StatefulWidget {
  final Function next;

  const PromoCodeWidget({Key key, this.next}) : super(key: key);

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.next();
      widget.next(true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return GetBuilder<AuthController>(builder: (controller) {
      return Form(
        key: controller.formKey3,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CommonTextWidget(
                text: 'Код акции',
                fontWeight: FontWeight.w500,
                size: 20,
                color: Color(0xff8793B4),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                enabled: false,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'КНАУФ',
                ),
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  controller.promoCode;
                },
              ),
            ),
            if (!isKeyboardVisible) const Spacer(),
            if (isKeyboardVisible)
              const SizedBox(
                height: 150,
              ),
            TextButton(
              onPressed: () {
                UrlLauncher.launchEmail();
              },
              child: const CommonTextWidget(
                text: 'Написать в поддержку',
                size: 16,
                color: Color(0xff3C6FE4),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  top: 5,
                  right: 25),
              child: Material(
                color: kGlobal,
                elevation: controller.loading != true ? 3 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                  onTap: controller.loading == true
                      ? null
                      : () async {
                          if (controller.formKey3.currentState.validate()) {
                            controller.formKey3.currentState.save();
                            controller.toggleLoading();
                            final result = await controller.userPromoCheck();
                            if (result is PromoResponseModel) {
                              if (result.code == 254) {
                                widget.next();
                              } else {
                                controller.toggleLoading();
                                CustomSnackBar.badSnackBar(
                                    context, 'Код не найден.');
                              }
                              controller.toggleLoading();
                            } else if (result is ErrorRequestPromo) {
                              controller.toggleLoading();
                              CustomSnackBar.badSnackBar(context, result.error);
                            }
                          }
                        },
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonTextWidget(
                            text: 'Далее',
                            fontWeight: FontWeight.w700,
                            size: 16,
                          ),
                          controller.loading == true
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.white),
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                        ],
                      ),
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
