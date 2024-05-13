import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_save/image_save.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:teklub/app/user/widgets/pasport_widget.dart';
import 'package:teklub/auth/controller/reg_form_controller.dart';
import 'package:teklub/auth/view/screens/auth_files.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme.dart';
import '../../../home/views/screens/pdf_faq_screen.dart';
import '../../models/sms_check_model.dart';
import '../../models/specs_model.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key key, this.smsResponseModelReg}) : super(key: key);

  final SmsResponseModelReg smsResponseModelReg;

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String region;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  String passDate1;
  String passDate2;
  String passDate3;

  Timer timer1;

  final maskFormatter1 = MaskTextInputFormatter(mask: '###-###');

  // void datePicker(context, int num) {
  //   DatePicker.showDatePicker(context,
  //       showTitleActions: true,
  //       theme: const DatePickerTheme(
  //         doneStyle: TextStyle(
  //           color: Color(
  //             0xff3C6FE4,
  //           ),
  //           fontWeight: FontWeight.w700,
  //         ),
  //         cancelStyle: TextStyle(
  //           color: Color(0xff49536D),
  //         ),
  //       ),
  //       onChanged: null, onConfirm: (date) {
  //     if (num == 1) {
  //       savePassDate1(date);
  //     } else if (num == 2) {
  //       savePassDate2(date);
  //     } else if (num == 3) {
  //       savePassDate3(date);
  //     }
  //   }, currentTime: DateTime.now(), locale: LocaleType.ru);
  // }

  String name;
  String lastName;
  String patranomic;
  String passSeries;
  String passNum;
  String kemVidan;
  String divisionCode;
  String placeOfBirth;
  String placeOfReg;
  String inn;
  // String selectedJobTitle = 'Закупщик';
  Uint8List saveAvatar;
  File avatar;

  @override
  void initState() {
    super.initState();
    getImageFromSandBox();
  }

  void getPhotoAvatar() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      avatar = File(result.files.single.path);
      if (avatar != null) {
        final CroppedFile res = await ImageCropper().cropImage(
          sourcePath: avatar.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square],
        );
        saveImageToSandBox(
          File(res.path),
        );

        setState(() {});
      }
    } else {
      // CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
  }

  Future<void> saveImageToSandBox(File data) async {
    try {
      Uint8List file = await data.readAsBytes();
      await ImageSave.saveImageToSandbox(file, "avatar.png");
      print(await data.readAsBytes());
      getImageFromSandBox();
      setState(() {});
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> getImageFromSandBox() async {
    try {
      List<Uint8List> files = await ImageSave.getImagesFromSandbox();
      if (files.isNotEmpty) {
        saveAvatar = files[0];

        setState(() {});
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> removeImageFromMemory() async {
    try {
      String imagePath = '';
      if (Platform.isAndroid) {
        final appDir = await getExternalStorageDirectory();
        imagePath = '${appDir.path}/Pictures/avatar.png';
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        imagePath = '${appDir.path}/Pictures/avatar.png';
      }
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        setState(() {
          saveAvatar = null;
        });
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final WIDTH = MediaQuery.of(context).size.width;
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kGlobalBlack,
      body: GetBuilder<RegFormController>(
          init: RegFormController(),
          builder: (controller) {
            // print(controller.firstName);
            return Stack(
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
                        child: Form(
                          key: controller.formKeyReg,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CommonTextWidget(
                                  text: 'Заполнить профиль',
                                  size: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff49536D),
                                ),
                              ),
                              // if (saveAvatar != null)
                              //   Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 30, bottom: 32),
                              //     child: SizedBox(
                              //       width: 110,
                              //       height: 110,
                              //       child: Stack(
                              //         alignment: Alignment.topRight,
                              //         children: [
                              //           Center(
                              //             child: SizedBox(
                              //               width: 90,
                              //               height: 90,
                              //               child: GestureDetector(
                              //                 onTap: () {
                              //                   getPhotoAvatar();
                              //                 },
                              //                 child: ClipRRect(
                              //                   borderRadius:
                              //                       BorderRadius.circular(20),
                              //                   child: Image.memory(saveAvatar),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //           InkWell(
                              //             onTap: () {
                              //               print('object');
                              //               removeImageFromMemory();
                              //             },
                              //             child: CircleAvatar(
                              //               backgroundColor:
                              //                   const Color(0xffEB4F4F),
                              //               radius: 15,
                              //               child: SvgPicture.asset(
                              //                   'assets/images/cancel1.svg'),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // if (saveAvatar == null)
                              //   Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 13, bottom: 32),
                              //     child: Container(
                              //       width: 100,
                              //       height: 100,
                              //       decoration: BoxDecoration(
                              //           color: const Color(0xffF3F7FF),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               spreadRadius: 0,
                              //               blurRadius: 0,
                              //               color: const Color(0xff0025C2)
                              //                   .withOpacity(0.1),
                              //             ),
                              //           ],
                              //           borderRadius:
                              //               BorderRadius.circular(12)),
                              //       child: Center(
                              //         child: IconButton(
                              //           onPressed: () {
                              //             getPhotoAvatar();
                              //           },
                              //           icon: const Icon(
                              //             Icons.local_see,
                              //             color: Color(0xff131313),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          labelText: 'Должность',
                                          border: OutlineInputBorder(),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isDense: true,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff8793B4),
                                            ),
                                            value: controller.savedPosition,
                                            items: (widget.smsResponseModelReg !=
                                                            null &&
                                                        widget
                                                            .smsResponseModelReg
                                                            .specializations
                                                            .isNotEmpty
                                                    ? widget
                                                        .smsResponseModelReg
                                                        .specializations[0]
                                                        .specializations
                                                    : <SpecsModel>[])
                                                .map<DropdownMenuItem<String>>(
                                                    (SpecsModel value) {
                                              // print(value.id);

                                              return DropdownMenuItem<String>(
                                                value: value.name, //49536D
                                                child: CommonTextWidget(
                                                  text: value.name,
                                                  size: 14,
                                                  color: Color(0xff49536D),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                if (newValue.toLowerCase() ==
                                                    'закупщик') {
                                                  controller.purchaser = true;
                                                } else {
                                                  controller.purchaser = false;
                                                }
                                                controller.officePositionId(
                                                    widget.smsResponseModelReg
                                                        .officePositions);
                                                controller.saveSpes(
                                                    newValue,
                                                    widget
                                                        .smsResponseModelReg
                                                        .specializations[0]
                                                        .specializations);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (controller.isPosition)
                                      const CommonTextWidget(
                                        text: "Введите должность",
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  controller: controller.firstNameController,
                                  decoration: const InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Имя',
                                      hintText: 'Введите имя'),
                                  keyboardType: TextInputType.text,
                                  // initialValue: controller.firstName,
                                  onChanged: (val) {
                                    controller.saveFirstName(val);
                                  },
                                  // onSaved: (val) {
                                  //   controller.saveFirstName(val);
                                  // },
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
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Фамилия',
                                      hintText: 'Введите фамилию'),
                                  keyboardType: TextInputType.text,
                                  controller: controller.secondNameController,
                                  onChanged: (val) {
                                    controller.saveSecondName(val);
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
                                  controller: controller.lastNameController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Отчество',
                                      hintText: 'Введите отчество'),
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    controller.savePatranomic(val);
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
                                  enabled: false,
                                  style: const TextStyle(color: Colors.grey),
                                  initialValue: controller.phone,
                                  inputFormatters: [controller.maskFormatter1],
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Номер телефона',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (val) {
                                    controller.savePhone(val);
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
                                      labelText: 'E-mail',
                                      hintText: 'Введите E-mail'),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (val) {
                                    controller.saveEmail(val);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Заполните поле';
                                    } else if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'Введенный вами email некорректен';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              if (controller.purchaser)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'МК-код',
                                      hintText: 'Введите МК-код',
                                      focusedBorder: controller.errorPoint
                                          ? const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              borderSide:
                                                  BorderSide(color: Colors.red))
                                          : const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                      enabledBorder: controller.errorPoint
                                          ? const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              borderSide:
                                                  BorderSide(color: Colors.red))
                                          : const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (val) {
                                      controller.saveMkCode(val);
                                    },
                                    validator: (value) {},
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25, top: 25),
                                child: InkWell(
                                  onTap: () {
                                    Get.delete<RegFormController>(force: true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PassportWidget(
                                          profileData: null,
                                          controller: controller,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 18 * fem, 15 * fem, 18 * fem),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffd20014)),
                                      borderRadius:
                                          BorderRadius.circular(12 * fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        CommonTextWidget(
                                          text: 'Заполнить паспортные данные',
                                          color: Color(0xff404040),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios_sharp,
                                            color: Color(0xffd20014)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.checkBoxUpdate(
                                            !controller.checkbox);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 2,
                                                color: Color(0xff49536D)
                                                    .withOpacity(0.3))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: controller.checkbox
                                                  ? kGlobal
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'Я прочитал и принял условия\n',
                                              style: TextStyle(
                                                color: Color(0xff8793B4),
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    '«Конфиденциальности данных»',
                                                style: const TextStyle(
                                                  color: Color(0xff8793B4),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        if (widget
                                                            .smsResponseModelReg
                                                            .files
                                                            .isNotEmpty) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      PdfViewer(
                                                                url: widget
                                                                    .smsResponseModelReg
                                                                    .files[1]
                                                                    .url,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                            const TextSpan(
                                              text:
                                                  ' и даю \nсогласие на обработку своих \nперсональных данных*',
                                              style: TextStyle(
                                                color: Color(0xff8793B4),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // GestureDetector(
                                      //   onTap: () async {
                                      //     String url =
                                      //         'https://www.knauf.ru/about/confidentiality/';
                                      //     _launchUrl(url);
                                      //   },
                                      //   child: const CommonTextWidget(
                                      //     text:
                                      //         'Я прочитал и принял условия «Конфиденциальности данных» и даю согласие на обработку своих персональных данных*',
                                      //     size: 14,
                                      //     color: Color(0xff8793B4),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.checkBoxUpdate2(
                                            !controller.checkbox2);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 2,
                                                color: Color(0xff49536D)
                                                    .withOpacity(0.3))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: controller.checkbox2
                                                  ? kGlobal
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'Я прочитал и принял условия \n',
                                              style: TextStyle(
                                                color: Color(0xff8793B4),
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                                text: '«Правил программы»',
                                                style: const TextStyle(
                                                  color: Color(0xff8793B4),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 15,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        if (widget
                                                            .smsResponseModelReg
                                                            .files
                                                            .isNotEmpty) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      PdfViewer(
                                                                url: widget
                                                                    .smsResponseModelReg
                                                                    .files[0]
                                                                    .url,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.05,
                                    top: 25,
                                    right: 25),
                                child: Material(
                                  elevation: controller.loading != true ? 3 : 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  color: controller.checkbox == false ||
                                          controller.checkbox2 == false
                                      ? Colors.grey[400]
                                      : kGlobal,
                                  child: InkWell(
                                    onTap: () async {
                                      controller.sendReg(context);
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
                                              text: 'Сохранить',
                                              fontWeight: FontWeight.w700,
                                              size: 16,
                                            ),
                                            controller.loading == true
                                                ? const SizedBox(
                                                    width: 15,
                                                    height: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.white,
                                                      color: kGlobal,
                                                    ),
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
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
