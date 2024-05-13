import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/challenge/models/promo_model.dart';

class WhereSendMoneyWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  // final String subString;

  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final Function() onTap;

  const WhereSendMoneyWidget({
    Key key,
    this.icon,
    this.color,
    this.title,
    // this.subString,

    this.model,
    this.passModel,
    this.promoModel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        child: InkWell(
          onTap: onTap ??
              () {
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      width: 90.w,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CommonTextWidget(
                            text: 'Раздел в разработке',
                            size: 22,
                            color: Color(0xff49536D),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const CommonTextWidget(
                                text: 'Понятно',
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      text: title,
                      fontWeight: FontWeight.w400,
                      size: 16,
                      fontFamily: 'Arial',
                      color: const Color(0xff49536D),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8),
                    //   child: CommonTextWidget(
                    //     text: subString,
                    //     size: 15,
                    //     color: const Color(0xff49536D),
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xff8793B4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
