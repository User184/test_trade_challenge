import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/common/components/common_text_widget.dart';
import '../../app/common/components/snack_bar.dart';
import '../data/api_referral.dart';
import '../models/CashbackModel.dart';

class ReferralController extends GetxController {
  bool _isSelectView = true;

  bool get isSelectView => _isSelectView;

  void showDialogCopy(context) async {
    await showDialog(
      context: context,
      builder: (_) => Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            height: 170,
            width: MediaQuery.of(context).size.width / 1.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonTextWidget(
                  text: 'Промокод скопирован',
                  fontWeight: FontWeight.w500,
                  size: 16,
                  overflow: TextOverflow.fade,
                  color: Color(0xff49536D),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff3C6FE4),
                          borderRadius: BorderRadius.circular(15)),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Center(
                        child: CommonTextWidget(
                          text: 'Хорошо!',
                          fontWeight: FontWeight.w700,
                          size: 16,
                          overflow: TextOverflow.fade,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> share(context, String referralCode) async {
  await ApiReferral.getCashback().then((value) async{
    if(value is CashbackModel){
      await Share.share(
        "Приглашаю тебя мотивационную программу PryanikOnline. Скачай приложение  ${Platform.isAndroid ? 'https://play.google.com/store/apps/details?id=com.retail.pryaniconline' :  'https://apps.apple.com/ru/app/pryanik-online/id1606709177'}, Введи промокод l8P6R0nWTU при регистрации и получи 500 баллов в подарок при сканировании чеков c акционными товарам на сумму 8500. Обменивай баллы на крутые призы в приложении!",
          subject: 'Пригласи друга'
      );
    }else if(value is ErrorRequestCashback){
      CustomSnackBar.badSnackBar(context, value.error);
    }
  });



  }

  void changePageView(bool select) {
    _isSelectView = select;
    update();
  }
}
