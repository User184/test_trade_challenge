import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/home/views/screens/money/add_certificate_screen.dart';
import 'package:teklub/home/views/screens/money/add_phone_screen.dart';

import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../../tests/models/test_model.dart';
import 'add_card_screen.dart';

class GetMoneySelectTypeScreen extends StatefulWidget {
  final String type;
  final PermissionModel4 model;
  final PromoModel promoModel;
  final PassModel passModel;
  final TestModel testModel;

  const GetMoneySelectTypeScreen(
      {Key key,
      this.type,
      this.model,
      this.promoModel,
      this.testModel,
      this.passModel})
      : super(key: key);

  @override
  _GetMoneySelectTypeScreenState createState() =>
      _GetMoneySelectTypeScreenState();
}

class _GetMoneySelectTypeScreenState extends State<GetMoneySelectTypeScreen> {
  String chosen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff3C6FE4),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff3C6FE4),
        centerTitle: true,
        title: const CommonTextWidget(
          text: 'Счет списания средств',
          size: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: const Color(0xffF3F7FF),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              chosen = 'rub';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: chosen == 'rub'
                                    ? Border.all(color: const Color(0xff3C6FE4))
                                    : null),
                            height: 80,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTextWidget(
                                        color: const Color(0xff49536D),
                                        text:
                                            '\u20BD ${widget.model == null ? '' : widget.model.data.rubBalance}',
                                        fontWeight: FontWeight.w700,
                                        size: 18,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: CommonTextWidget(
                                          color: Color(0xff49536D),
                                          text: 'Рублевый кошелек',
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    child: chosen == 'rub'
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : null,
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: chosen == 'rub'
                                          ? const Color(0xff3C6FE4)
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(7),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: const Color(0xffF3F7FF),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              chosen = 'points';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: chosen == 'points'
                                    ? Border.all(
                                        color: const Color(0xff3C6FE4),
                                      )
                                    : null),
                            height: 80,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTextWidget(
                                        color: const Color(0xff49536D),
                                        text:
                                            '\u20BD ${widget.model == null ? '' : widget.model.data.pointsBalance}',
                                        fontWeight: FontWeight.w700,
                                        size: 18,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: CommonTextWidget(
                                          color: Color(0xff49536D),
                                          text: 'Бонусный кошелек',
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    child: chosen == 'points'
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : null,
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: chosen == 'points'
                                          ? const Color(0xff3C6FE4)
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(7),
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
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          bottom: MediaQuery.of(context).size.height * 0.05,
                          top: 5,
                          right: 25),
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: const Color(0xff3C6FE4),
                        child: InkWell(
                          onTap: () async {
                            if (chosen == null) {
                              CustomSnackBar.badSnackBar(
                                  context, 'Выберите счет');
                            } else {
                              if (widget.type == 'card') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CardScreen(
                                      model: widget.model,
                                      promoModel: widget.promoModel,
                                      passModel: widget.passModel,
                                      testModel: widget.testModel,
                                      rub: widget.model.data.rubBalance
                                          .toString(),
                                      point: widget.model.data.pointsBalance
                                          .toString(),
                                      wallet: chosen,
                                    ),
                                  ),
                                );
                              } else if (widget.type == 'phone') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPhoneScreen(
                                      model: widget.model,
                                      rub: widget.model.data.rubBalance
                                          .toString(),
                                      point: widget.model.data.pointsBalance
                                          .toString(),
                                      wallet: chosen,
                                    ),
                                  ),
                                );
                              } else if (widget.type == 'certificate') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddSerticateScreen(
                                      model: widget.model,
                                      rub: widget.model.data.rubBalance
                                          .toString(),
                                      point: widget.model.data.pointsBalance
                                          .toString(),
                                      wallet: chosen,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CommonTextWidget(
                                    text: 'Далее',
                                    fontWeight: FontWeight.w700,
                                    size: 16,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
