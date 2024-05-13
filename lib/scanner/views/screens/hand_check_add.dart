import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/scanner/data/api_service.dart';
import 'package:teklub/scanner/models/scan_models.dart';
import 'package:teklub/scanner/views/screens/hand_check_add_compl.dart';

class HandCheckAddScreen extends StatefulWidget {
  const HandCheckAddScreen({Key key}) : super(key: key);

  @override
  _HandCheckAddScreenState createState() => _HandCheckAddScreenState();
}

class _HandCheckAddScreenState extends State<HandCheckAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String buyDate;
  String buyTime;
  String t;
  String s;
  String fn;
  String fp;
  String i;
  String n;

  bool loading = false;

  void savePassDate1(val) {
    var result = val.toString().split(' ');

    buyDate = result.first.toString().substring(0, 10);
    buyTime = result.last.toString().substring(0, 8);

    setState(() {});
  }

  void timePassDate1(val) {
    List temp = [];
    List tem2 = [];
    temp = val.toString().split(' ');
    var temp2 = temp[1].toString().split(':');

    buyTime = "${temp2[0]}${temp2[1]}${temp2[2].substring(0, 2)}";

    setState(() {});
  }

  String addTimeFormat(data) {
    var x = data;
    x = x.substring(0, 2) + ":" + x.substring(2, 4) + ":" + x.substring(4, 6);
    return x;
  }

  void datePicker(context, int num) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        theme: const DatePickerTheme(
          doneStyle: TextStyle(
            color: Color(
              0xff3C6FE4,
            ),
            fontWeight: FontWeight.w700,
          ),
          cancelStyle: TextStyle(
            color: Color(0xff49536D),
          ),
        ),
        onChanged: null, onConfirm: (date) {
      savePassDate1(date);
    }, currentTime: DateTime.now(), locale: LocaleType.ru);
  }

  void timePicker(context) {
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        theme: const DatePickerTheme(
          doneStyle: TextStyle(
            color: Color(
              0xff3C6FE4,
            ),
            fontWeight: FontWeight.w700,
          ),
          cancelStyle: TextStyle(
            color: Color(0xff49536D),
          ),
        ),
        onChanged: null, onConfirm: (date) {
      timePassDate1(date);
    }, currentTime: DateTime.now(), locale: LocaleType.ru);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff3C6FE4),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xff3C6FE4),
        // ),
        body: Stack(
          children: [
            Padding(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CommonTextWidget(
                                text: 'Ввести вручную',
                                size: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff49536D),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300]),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.highlight_off),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Общая сумма чека',
                                          hintText: '999.99'),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      onSaved: (val) {
                                        s = val.replaceAll(',', '.');
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () {
                                        datePicker(context, 1);
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                              color: Color(0xff49536D)),
                                          suffixIcon:
                                              const Icon(Icons.calendar_today),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Дата покупки',
                                          hintText: buyDate != null
                                              ? '$buyDate ${buyTime.substring(0, 5)}'
                                              : 'ДД.ММ.ГГГГ'),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //       left: 25.w, right: 25.w, bottom: 25.h),
                                  //   child: TextFormField(
                                  //     readOnly: true,
                                  //     onTap: () {
                                  //       timePicker(context);
                                  //     },
                                  //     textInputAction: TextInputAction.next,
                                  //     decoration: InputDecoration(
                                  //
                                  //         hintStyle: const TextStyle(
                                  //             color: Color(0xff49536D)),
                                  //         suffixIcon:
                                  //             const Icon(Icons.access_time),
                                  //         floatingLabelBehavior:
                                  //             FloatingLabelBehavior.always,
                                  //         labelText: 'Время покупки',
                                  //         hintText:buyTime != null ? addTimeFormat(buyTime) ?? '--:--' : '--:--'),
                                  //     keyboardType: TextInputType.text,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      maxLength: 16,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText:
                                              'ФН(фискальный накопитель)',
                                          hintText:
                                              'ФН(фискальный накопитель)'),
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) {
                                        fn = val;
                                      },
                                      validator: (value) {
                                        if (value.length < 16) {
                                          return 'Поле должно содержать 16 символов';
                                        }
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'ФД(фискальный документ)',
                                          hintText: 'ФД(фискальный документ)'),
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) {
                                        i = val;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText:
                                              'ФПД(фискальный признак документа)',
                                          hintText:
                                              'ФПД(фискальный признак документа)'),
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) {
                                        fp = val;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05,
                                top: 5,
                                right: 25,
                              ),
                              child: Material(
                                elevation: loading != true ? 3 : 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                color: const Color(0xff3C6FE4),
                                child: InkWell(
                                  onTap: loading == true
                                      ? null
                                      : () async {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                            setState(() {
                                              loading = true;
                                            });

                                            t = "${buyDate.replaceAll('-', '')}T${buyTime.replaceAll(':', '')}";
                                            final res =
                                                await ApiScanService.scanChecks(
                                              ScanRequestModel(
                                                  t: t,
                                                  s: s,
                                                  fn: fn,
                                                  i: i,
                                                  fp: fp,
                                                  n: '1'),
                                            );
                                            if (res is ErrorRequestScan) {
                                              CustomSnackBar.badSnackBar(
                                                  context,
                                                  'Ошибка. Попробуйте позже');
                                            }
                                            if (res is SuccessRequestScan) {
                                              if (res.success == 'true') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HandCheckAddScreenCompl(
                                                      result: 'true',
                                                    ),
                                                  ),
                                                );
                                              } else if (res.success ==
                                                  'false') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HandCheckAddScreenCompl(
                                                            result: 'false'),
                                                  ),
                                                );
                                              }
                                            }

                                            setState(() {
                                              loading = false;
                                            });
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
                                        children: [
                                          const CommonTextWidget(
                                            text: 'Зарегистрировать',
                                            fontWeight: FontWeight.w700,
                                            size: 16,
                                          ),
                                          loading == true
                                              ? const SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.white),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
