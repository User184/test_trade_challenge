import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:teklub/app/user/widgets/pasport_widget.dart';

import '../../../home/views/screens/pdf_faq_screen.dart';
import '/app/routes/route.dart' as route;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_save/image_save.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/covert_data_time.dart';
import 'package:teklub/app/user/data/api_setting_user.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/controller/reg_form_controller.dart';
import '../../../auth/view/screens/auth_files.dart';
import '../../theme.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({Key key}) : super(key: key);

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  HomeController homeController = Get.find();

  String email = '';
  bool emailLoading = false;

  File avatar;

  // final _formKey = GlobalKey<FormState>();
  Uint8List saveAvatar;

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

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  final maskFormatter1 = MaskTextInputFormatter(mask: '+7 (###) ###-##-##');

  Future<void> saveImageToSandBox(File data) async {
    try {
      Uint8List file = await data.readAsBytes();
      await ImageSave.saveImageToSandbox(file, "avatar.png");
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
        homeController.avatar.value = saveAvatar;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future removeImageFromMemory() async {
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
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFromSandBox();
  }

  final Future<GetProfileDataModel> getProfileData =
      ApiSettingUser.getProfileData();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onVerticalDragDown,
          GestureType.onVerticalDragStart,
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kGlobalBlack,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: kGlobalBlack,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, route.homeScreen);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: const CommonTextWidget(
              text: 'Профиль',
              size: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
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
                    child: SingleChildScrollView(
                      child: FutureBuilder<GetProfileDataModel>(
                          future: getProfileData,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.4),
                                child: const Center(
                                  child: CommonTextWidget(
                                    text: 'Ошибка. Нет сети',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepOrange,
                                    size: 20,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              final isEditPasspotr =
                                  snapshot.data.data.passportData.status ==
                                      'rejected';
                              return Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: CommonTextWidget(
                                      text: 'Заполнить профиль',
                                      size: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                      color: Color(0xff49536D),
                                    ),
                                  ),
                                  if (snapshot.data.data.passportData
                                          .passportNumber !=
                                      null)
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: colorStatus(snapshot
                                            .data.data.passportData.status),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            iconStatus(snapshot
                                                .data.data.passportData.status),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CommonTextWidget(
                                              text: titleStatus(snapshot.data
                                                  .data.passportData.status),
                                              size: 12,
                                              color: snapshot
                                                          .data
                                                          .data
                                                          .passportData
                                                          .status ==
                                                      'on_verification'
                                                  ? const Color(0xff8793B4)
                                                  : Colors.white,
                                              fontFamily: 'Arial',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: CommonTextWidget(
                                      text: snapshot
                                              .data.data.passportData.comment ??
                                          "",
                                      size: 16,
                                      color: const Color(0xff8793B4),
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.w400,
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
                                  //                       BorderRadius.circular(
                                  //                           20),
                                  //                   child: Image.memory(
                                  //                       saveAvatar),
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
                                  // // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, bottom: 25),
                                  //   child: Container(
                                  //     child: InputDecorator(
                                  //       decoration: InputDecoration(
                                  //         labelText: 'Должность',
                                  //         border: OutlineInputBorder(),
                                  //       ),
                                  //       child: DropdownButtonHideUnderline(
                                  //         child: DropdownButton<String>(
                                  //           dropdownColor: Colors.white,
                                  //           isDense: true,
                                  //           isExpanded: true,
                                  //           icon: const Icon(
                                  //             Icons.keyboard_arrow_down,
                                  //             color: Color(0xff8793B4),
                                  //           ),
                                  //           value: controller.savedPosition,
                                  //           items: <String>[
                                  //             'Закупщик',
                                  //             'Торговый представитель',
                                  //           ].map<DropdownMenuItem<String>>(
                                  //               (String value) {
                                  //             return DropdownMenuItem<String>(
                                  //               value: value, //49536D
                                  //               child: CommonTextWidget(
                                  //                 text: value,
                                  //                 size: 14,
                                  //                 color: Color(0xff49536D),
                                  //               ),
                                  //             );
                                  //           }).toList(),
                                  //           onChanged: (String newValue) {
                                  //             setState(() {
                                  //               if (newValue == 'Закупщик') {
                                  //                 controller.purchaser = true;
                                  //               } else {
                                  //                 controller.purchaser = false;
                                  //               }
                                  //               controller
                                  //                   .savePosition(newValue);
                                  //             });
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  if (snapshot.data.data.officePositionTitle !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25, bottom: 25),
                                      child: GetBuilder<RegFormController>(
                                          init: RegFormController(),
                                          builder: (controller) {
                                            return InkWell(
                                              onTap: () async {},
                                              child: TextFormField(
                                                enabled: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                initialValue: snapshot
                                                        .data
                                                        .data
                                                        .specializations
                                                        .isNotEmpty
                                                    ? snapshot.data.data
                                                        .specializations[0].name
                                                    : "",
                                                decoration: InputDecoration(
                                                  suffixIcon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: Color(0xff8793B4),
                                                  ),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  labelText: 'Должность',
                                                  hintStyle: TextStyle(
                                                    color: snapshot.data.data
                                                                .specializations !=
                                                            null
                                                        ? Colors.grey
                                                        : const Color(
                                                                0xFF009FE3)
                                                            .withOpacity(.6),
                                                    // const Color(0xFF009FE34D)
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            );
                                          }),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      enabled: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      initialValue: snapshot.data.data.name,
                                      style:
                                          TextStyle(color: Color(0xff49536D)),
                                      textInputAction: TextInputAction.next,

                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Имя',
                                          hintText: 'Введите имя'),
                                      keyboardType: TextInputType.text,
                                      // initialValue: controller.firstName,
                                      onChanged: (val) {},
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
                                      style:
                                          TextStyle(color: Color(0xff49536D)),
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      initialValue: snapshot.data.data.lastName,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Фамилия',
                                          hintText: 'Введите фамилию'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (val) {},
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
                                      style:
                                          TextStyle(color: Color(0xff49536D)),
                                      initialValue:
                                          snapshot.data.data.patronymic,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Отчество',
                                          hintText: 'Введите отчество'),
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {},
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
                                      style:
                                          TextStyle(color: Color(0xff49536D)),
                                      initialValue: snapshot.data.data.phone,
                                      inputFormatters: [maskFormatter1],
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Номер телефона',
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) {},
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
                                      initialValue: snapshot.data.data.email,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          color: Color(0xff49536D)),
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'E-mail',
                                          hintText: 'Введите E-mail'),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (val) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        } else if (!value.contains('@')) {
                                          return 'Неверный формат';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (snapshot.data.data.specializations
                                          .isNotEmpty &&
                                      snapshot.data.data.specializations[0].name
                                              .toLowerCase() ==
                                          "закупщик")
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextFormField(
                                          enabled: false,
                                          initialValue:
                                              snapshot.data.data.tradePoint.inn,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: 'МК-код',
                                              hintText: 'Введите МК-код'),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (val) {
                                            // controller.saveEmail(val);
                                          },
                                          validator: (value) {}),
                                    ),
                                  if (snapshot.data.data.passportData
                                          .passportNumber !=
                                      null) ...[
                                    GetBuilder<RegFormController>(
                                        init: RegFormController(),
                                        builder: (controller) {
                                          return Form(
                                            key: controller.userKeyReg,
                                            child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 24),
                                                  child: CommonTextWidget(
                                                    text: 'Паспортные данные',
                                                    size: 18,
                                                    fontFamily:
                                                        'SFProTextRegular',
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff49536D),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    controller: controller
                                                        .firstNameController
                                                      ..text = snapshot
                                                          .data.data.name
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: snapshot
                                                                  .data
                                                                  .data
                                                                  .name
                                                                  .length),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText: 'Имя',
                                                        hintText:
                                                            'Введите имя'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveFirstName(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    controller: controller
                                                        .secondNameController
                                                      ..text = snapshot
                                                          .data.data.lastName
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: snapshot
                                                                  .data
                                                                  .data
                                                                  .lastName
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText: 'Фамилия',
                                                        hintText:
                                                            'Введите фамилию'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveSecondName(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    controller: controller
                                                        .lastNameController
                                                      ..text = snapshot
                                                          .data.data.patronymic
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: snapshot
                                                                  .data
                                                                  .data
                                                                  .patronymic
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText: 'Отчество',
                                                        hintText:
                                                            'Введите отчество'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      print('objec3333t$val');
                                                      controller
                                                          .savePatranomic(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    inputFormatters: [
                                                      controller.birthDay
                                                    ],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    controller: controller
                                                        .dateOfBirthController
                                                      ..text = (controller
                                                              .dateOfBirthController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .dateOfBirth !=
                                                                  null
                                                              ? convertDataTime(
                                                                  DateTime.parse(snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .dateOfBirth))
                                                              : ""
                                                          : controller
                                                              .dateOfBirthController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .dateOfBirthController
                                                                  .text
                                                                  .length),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        suffixIcon: SizedBox(
                                                          width: 20,
                                                          // Adjust the width as needed
                                                          height: 20,
                                                          // Adjust the height as needed
                                                          child:
                                                              Transform.scale(
                                                            scale: 0.6,
                                                            // Adjust the scale factor as needed
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/calendar.svg',
                                                            ),
                                                          ),
                                                        ),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Дата рождения',
                                                        hintText: 'дд.мм.гггг'),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onSaved: (val) {
                                                      controller
                                                          .savePassDate2(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    inputFormatters: [
                                                      controller
                                                          .maskSeriesNumber
                                                    ],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    controller: controller
                                                        .passportSeriesController
                                                      ..text = (controller
                                                              .passportSeriesController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .seriesNumber ??
                                                              ''
                                                          : controller
                                                              .passportSeriesController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .passportSeriesController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Серия паспорт',
                                                        hintText:
                                                            'Введите серию паспорта'),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onSaved: (val) {
                                                      controller
                                                          .savePassportSeries(
                                                              val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    enabled: isEditPasspotr,
                                                    inputFormatters: [
                                                      controller
                                                          .maskNumberPassport
                                                    ],
                                                    controller: controller
                                                        .numberPassportController
                                                      ..text = (controller
                                                              .numberPassportController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .passportNumber !=
                                                                  null
                                                              ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .passportNumber
                                                              : ''
                                                          : controller
                                                              .numberPassportController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .numberPassportController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Номер паспорта',
                                                        hintText:
                                                            'Введите номер паспорта'),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onSaved: (val) {
                                                      controller
                                                          .savePassportNumber(
                                                              val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    enabled: isEditPasspotr,
                                                    controller: (controller
                                                        .issuedByController
                                                      ..text = controller
                                                              .issuedByController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .issuedBy !=
                                                                  null
                                                              ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .issuedBy
                                                              : ''
                                                          : controller
                                                              .issuedByController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .issuedByController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText: 'Кем выдан',
                                                        hintText:
                                                            'Пример заполнения: ТП№1 ОУФМС'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveKemVidan(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    controller: controller
                                                        .dateOfIssueController
                                                      ..text = (controller
                                                              .dateOfIssueController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .dateOfIssue !=
                                                                  null
                                                              ? convertDataTime(
                                                                  DateTime.parse(snapshot
                                                                      .data
                                                                      .data
                                                                      .passportData
                                                                      .dateOfIssue))
                                                              : ''
                                                          : controller
                                                              .dateOfIssueController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .dateOfIssueController
                                                                  .text
                                                                  .length),
                                                    enabled: isEditPasspotr,
                                                    inputFormatters: [
                                                      controller.dataVish
                                                    ],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        suffixIcon: SizedBox(
                                                          width: 20,
                                                          // Adjust the width as needed
                                                          height: 20,
                                                          // Adjust the height as needed
                                                          child:
                                                              Transform.scale(
                                                            scale: 0.6,
                                                            // Adjust the scale factor as needed
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/calendar.svg',
                                                            ),
                                                          ),
                                                        ),
                                                        labelText:
                                                            'Дата выдачи паспорта',
                                                        hintText: 'дд.мм.гггг'),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onSaved: (val) {
                                                      controller
                                                          .savePassDate1(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    inputFormatters: [
                                                      controller.maskCode
                                                    ],
                                                    controller: controller
                                                        .codeVeshController
                                                      ..text = (controller
                                                              .codeVeshController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .subdivisionCode ??
                                                              ""
                                                          : controller
                                                              .codeVeshController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .codeVeshController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Код подразделения',
                                                        hintText:
                                                            'Пример: 111-111'),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveCodeDivision(
                                                              val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    enabled: isEditPasspotr,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    controller: controller
                                                        .placeOfBirthController
                                                      ..text = (controller
                                                              .placeOfBirthController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .placeOfBirth ??
                                                              ""
                                                          : controller
                                                              .placeOfBirthController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .placeOfBirthController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Место рождения',
                                                        hintText:
                                                            'Введите место рождения'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveBirthPlace(val);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: InkWell(
                                                    child: TextFormField(
                                                      controller: controller
                                                          .regController
                                                        ..text = (controller
                                                                .regController
                                                                .text
                                                                .isEmpty
                                                            ? snapshot
                                                                        .data
                                                                        .data
                                                                        .passportData
                                                                        .dateOfRegistration !=
                                                                    null
                                                                ? convertDataTime(
                                                                    DateTime.parse(snapshot
                                                                            .data
                                                                            .data
                                                                            .passportData
                                                                            .dateOfRegistration ??
                                                                        ""))
                                                                : ""
                                                            : controller
                                                                .regController
                                                                .text)
                                                        ..selection = TextSelection
                                                            .collapsed(
                                                                offset: controller
                                                                    .regController
                                                                    .text
                                                                    .length),
                                                      enabled: isEditPasspotr,
                                                      inputFormatters: [
                                                        controller.dataReg
                                                      ],
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff49536D)),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              suffixIcon:
                                                                  SizedBox(
                                                                width: 20,
                                                                // Adjust the width as needed
                                                                height: 20,
                                                                // Adjust the height as needed
                                                                child: Transform
                                                                    .scale(
                                                                  scale: 0.6,
                                                                  // Adjust the scale factor as needed
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/images/calendar.svg',
                                                                  ),
                                                                ),
                                                              ),
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              labelText:
                                                                  'Дата регистрации',
                                                              hintText:
                                                                  'дд.мм.гггг'),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onSaved: (val) {
                                                        controller
                                                            .savePassDate3(val);
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Заполните поле';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    enabled: isEditPasspotr,
                                                    controller: controller
                                                        .placeOfRegistrationController
                                                      ..text = (controller
                                                              .placeOfRegistrationController
                                                              .text
                                                              .isEmpty
                                                          ? snapshot
                                                                  .data
                                                                  .data
                                                                  .passportData
                                                                  .placeOfRegistration ??
                                                              ""
                                                          : controller
                                                              .placeOfRegistrationController
                                                              .text)
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: controller
                                                                  .placeOfRegistrationController
                                                                  .text
                                                                  .length),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText:
                                                            'Место регистрации',
                                                        hintText:
                                                            'Введите место регистрации'),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (val) {
                                                      controller
                                                          .saveRegistrationPlace(
                                                              val);
                                                    },
                                                    validator: (value) {},
                                                  ),
                                                ),
                                                // if (snapshot.data.data.inn != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff49536D)),
                                                    enabled: isEditPasspotr,
                                                    initialValue:
                                                        snapshot.data.data.inn,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          12),
                                                    ],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: const InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        labelText: 'ИНН',
                                                        hintText:
                                                            'Например: 1231123123'),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onSaved: (val) {
                                                      controller.saveInn(
                                                          context, val);
                                                    },
                                                    validator: (value) {
                                                      if (value.length < 12) {
                                                        return 'Заполните поле';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                //Фото лицевой стороны  passportFront

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: CommonTextWidget(
                                                          text:
                                                              'Фото лицевой стороны',
                                                          size: 14,
                                                          fontFamily:
                                                              'SFProTextRegular',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff131313),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      ((snapshot.data.data
                                                                              .passportData !=
                                                                          null &&
                                                                      snapshot
                                                                              .data
                                                                              .data
                                                                              .passportData
                                                                              .passportFront !=
                                                                          null &&
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .passportData
                                                                          .passportFront
                                                                          .last
                                                                          .url
                                                                          .isNotEmpty) ||
                                                                  (controller
                                                                          .facePicker !=
                                                                      null)) &&
                                                              !controller
                                                                  .removefacePicker
                                                          ? SizedBox(
                                                              height: 150,
                                                              width: double
                                                                  .infinity,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.2,
                                                                      // height: 92,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: controller.facePicker ==
                                                                                null
                                                                            ? Image.network(
                                                                                snapshot.data.data.passportData.passportFront.last.url,
                                                                                fit: BoxFit.fitWidth,
                                                                              )
                                                                            : Image.file(
                                                                                controller.facePicker,
                                                                                fit: BoxFit.fitWidth,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (isEditPasspotr)
                                                                    InkWell(
                                                                      onTap: isEditPasspotr
                                                                          ? () => controller.removeFacePicker(
                                                                              context,
                                                                              isReg: false)
                                                                          : null,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            const Color(0xffEB4F4F),
                                                                        radius:
                                                                            15,
                                                                        child: SvgPicture.asset(
                                                                            'assets/images/cancel1.svg'),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap:
                                                                  isEditPasspotr
                                                                      ? () {
                                                                          controller.getPhotos(
                                                                              context,
                                                                              0);
                                                                        }
                                                                      : null,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: const Color(
                                                                      0xffF9F9F9),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: const Color(
                                                                              0xff1D1D1D)
                                                                          .withOpacity(
                                                                              0.1),
                                                                      spreadRadius:
                                                                          0,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              2),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 15,
                                                                      top: 25,
                                                                      bottom:
                                                                          25),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            55,
                                                                        height:
                                                                            55,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              spreadRadius: 0,
                                                                              blurRadius: 0,
                                                                              color: const Color(0xff0025C2).withOpacity(0.1),
                                                                            ),
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              // getPhotoAvatar();
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.local_see,
                                                                              color: Color(0xffED1D24),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              24),
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: const [
                                                                            SizedBox(
                                                                              height: 30,
                                                                              child: CommonTextWidget(
                                                                                text: 'Загрузить',
                                                                                fontWeight: FontWeight.w700,
                                                                                size: 16,
                                                                                color: Color(0xff131313),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 30,
                                                                              child: CommonTextWidget(
                                                                                text: 'Не более 2 мб',
                                                                                fontWeight: FontWeight.w400,
                                                                                size: 14,
                                                                                color: Color(0xff8793B4),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 25),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: CommonTextWidget(
                                                          text:
                                                              'Фото регистрации',
                                                          size: 14,
                                                          fontFamily:
                                                              'SFProTextRegular',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff131313),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      ((snapshot.data.data
                                                                              .passportData !=
                                                                          null &&
                                                                      snapshot
                                                                              .data
                                                                              .data
                                                                              .passportData
                                                                              .passportAddress !=
                                                                          null &&
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .passportData
                                                                          .passportAddress
                                                                          .last
                                                                          .url
                                                                          .isNotEmpty) ||
                                                                  (controller
                                                                          .regPicker !=
                                                                      null)) &&
                                                              !controller
                                                                  .removeregPicker
                                                          ? SizedBox(
                                                              height: 150,
                                                              width: double
                                                                  .infinity,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.2,
                                                                      // height: 92,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: controller.regPicker ==
                                                                                null
                                                                            ? Image.network(
                                                                                snapshot.data.data.passportData.passportAddress.last.url,
                                                                                fit: BoxFit.fitWidth,
                                                                              )
                                                                            : Image.file(
                                                                                controller.regPicker,
                                                                                fit: BoxFit.fitWidth,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (isEditPasspotr)
                                                                    InkWell(
                                                                      onTap: isEditPasspotr
                                                                          ? () => controller.removeRegPicker(
                                                                              context,
                                                                              isReg: false)
                                                                          : null,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            const Color(0xffEB4F4F),
                                                                        radius:
                                                                            15,
                                                                        child: SvgPicture.asset(
                                                                            'assets/images/cancel1.svg'),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap:
                                                                  isEditPasspotr
                                                                      ? () {
                                                                          controller.getPhotos(
                                                                              context,
                                                                              1);
                                                                        }
                                                                      : null,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: const Color(
                                                                      0xffF9F9F9),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: const Color(
                                                                              0xff1D1D1D)
                                                                          .withOpacity(
                                                                              0.1),
                                                                      spreadRadius:
                                                                          0,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              2),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 15,
                                                                      top: 25,
                                                                      bottom:
                                                                          25),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            55,
                                                                        height:
                                                                            55,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              spreadRadius: 0,
                                                                              blurRadius: 0,
                                                                              color: const Color(0xff0025C2).withOpacity(0.1),
                                                                            ),
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              // getPhotoAvatar();
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.local_see,
                                                                              color: Color(0xffED1D24),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              24),
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: const [
                                                                            SizedBox(
                                                                              height: 30,
                                                                              child: CommonTextWidget(
                                                                                text: 'Загрузить',
                                                                                fontWeight: FontWeight.w700,
                                                                                size: 16,
                                                                                color: Color(0xff131313),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 30,
                                                                              child: CommonTextWidget(
                                                                                text: 'Не более 2 мб',
                                                                                fontWeight: FontWeight.w400,
                                                                                size: 14,
                                                                                color: Color(0xff8793B4),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                                if (isEditPasspotr)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 25,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        top: 25,
                                                        right: 25),
                                                    child: Material(
                                                      elevation: 10,
                                                      // shadowColor: Colors.grey[400],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                      color: kGlobal,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          if (isEditPasspotr) {
                                                            if (controller
                                                                .userKeyReg
                                                                .currentState
                                                                .validate()) {
                                                              controller
                                                                  .userKeyReg
                                                                  .currentState
                                                                  .save();
                                                              await controller
                                                                  .putPassportProfileData();
                                                              controller
                                                                  .userKeyReg
                                                                  .currentState
                                                                  .reset();
                                                            }
                                                            Navigator
                                                                .pushReplacementNamed(
                                                              context,
                                                              route
                                                                  .userSettingsScreen,
                                                            );
                                                          }
                                                          // Navigator.pop(context);
                                                        },
                                                        child: SizedBox(
                                                          height: 70,
                                                          width:
                                                              double.infinity,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const CommonTextWidget(
                                                                  text:
                                                                      'Сохранить',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  size: 16,
                                                                ),
                                                                !controller
                                                                        .loadingPassport
                                                                    ? const SizedBox(
                                                                        width:
                                                                            15,
                                                                        height:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_forward,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    : const CircularProgressIndicator(
                                                                        color:
                                                                            kGlobal,
                                                                        backgroundColor:
                                                                            Colors.white)
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
                                        }),
                                  ] else
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          bottom: 25,
                                          top: 25),
                                      child: InkWell(
                                        onTap: () {
                                          Get.delete<RegFormController>(
                                              force: true);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PassportWidget(
                                                isProfile: true,
                                                profileData: snapshot.data,
                                                controller: Get.put(
                                                    RegFormController()),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(15 * fem,
                                              18 * fem, 15 * fem, 18 * fem),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffd20014)),
                                            borderRadius:
                                                BorderRadius.circular(12 * fem),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              CommonTextWidget(
                                                text:
                                                    'Заполнить паспортные данные',
                                                color: Color(0xff404040),
                                              ),
                                              Spacer(),
                                              Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  color: Color(0xffd20014)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, bottom: 25),
                                  //   child: TextFormField(
                                  //     textCapitalization:
                                  //         TextCapitalization.sentences,
                                  //     textInputAction: TextInputAction.next,
                                  //     decoration: const InputDecoration(
                                  //         floatingLabelBehavior:
                                  //             FloatingLabelBehavior.always,
                                  //         labelText: 'Город',
                                  //         hintText: 'Введите ваш город'),
                                  //     keyboardType: TextInputType.text,
                                  //     onChanged: (val) {
                                  //       controller.city = val;
                                  //       if (timer1 != null) {
                                  //         timer1.cancel();
                                  //         timer1 = Timer(
                                  //           const Duration(milliseconds: 1500),
                                  //           () async {
                                  //             final res =
                                  //                 await ApiSettingUser.setCity(
                                  //               controller.city.trim(),
                                  //             );
                                  //             if (res == 'Город не найден') {
                                  //               region = 'Регион не найден';
                                  //               controller.regionID = null;
                                  //               setState(() {});
                                  //             } else {
                                  //               Map res2 = jsonDecode(res);
                                  //               region = res2['data']['name'];
                                  //               controller.regionID =
                                  //                   res2['data']['id'].toString();
                                  //               setState(() {});
                                  //             }
                                  //           },
                                  //         );
                                  //       } else {
                                  //         timer1 = Timer(
                                  //           const Duration(milliseconds: 1500),
                                  //           () async {
                                  //             final res =
                                  //                 await ApiSettingUser.setCity(
                                  //               controller.city.trim(),
                                  //             );
                                  //             if (res == 'Город не найден') {
                                  //               region = 'Регион не найден';
                                  //               controller.regionID = null;
                                  //               setState(() {});
                                  //             } else {
                                  //               Map res2 = jsonDecode(res);
                                  //               region = res2['data']['name'];
                                  //               controller.regionID =
                                  //                   res2['data']['id'];
                                  //               setState(() {});
                                  //             }
                                  //           },
                                  //         );
                                  //       }
                                  //     },
                                  //     onSaved: (val) {
                                  //       controller.saveCity(val);
                                  //     },
                                  //     validator: (value) {
                                  //       if (value == null || value.isEmpty) {
                                  //         return 'Заполните поле';
                                  //       }
                                  //       return null;
                                  //     },
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, bottom: 25),
                                  //   child: TextFormField(
                                  //     enabled: false,
                                  //     textInputAction: TextInputAction.next,
                                  //     decoration: InputDecoration(
                                  //         floatingLabelBehavior:
                                  //             FloatingLabelBehavior.always,
                                  //         labelText: 'Регион',
                                  //         hintText: region ?? '-'),
                                  //     keyboardType: TextInputType.text,
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, bottom: 25),
                                  //   child: InkWell(
                                  //     onTap: () async {
                                  //       await controller.getSpecsFromAuth();
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) => SpecsScreen(
                                  //             pageName: PageName.Reg,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //     child: TextFormField(
                                  //       enabled: false,
                                  //       textInputAction: TextInputAction.next,
                                  //       decoration: InputDecoration(
                                  //           floatingLabelBehavior:
                                  //               FloatingLabelBehavior.always,
                                  //           labelText: 'Специализация',
                                  //           hintText:
                                  //               controller.getChoesedSpecs() == ''
                                  //                   ? 'Выберите специализацию'
                                  //                   : controller.getChoesedSpecs()),
                                  //       keyboardType: TextInputType.text,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, bottom: 25),
                                  //   child: TextFormField(
                                  //     controller: controller.promoController,
                                  //     textInputAction: TextInputAction.next,
                                  //     decoration: InputDecoration(
                                  //         floatingLabelBehavior:
                                  //             FloatingLabelBehavior.always,
                                  //         labelText: 'Промокод',
                                  //         hintText:
                                  //             controller.promoController.text == ''
                                  //                 ? 'Введите промокод'
                                  //                 : controller
                                  //                     .promoController.text),
                                  //     keyboardType: TextInputType.text,
                                  //     onSaved: (val) {},
                                  //   ),
                                  // ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.4),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: kGlobal,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconStatus(String status) {
    switch (status) {
      case 'verified':
        return const Icon(
          Icons.check_circle,
          color: Colors.white,
        );
      case 'on_verification':
        return const Icon(
          Icons.watch_later_outlined,
          color: Color(0xff8793B4),
        );
      default:
        return const Icon(
          Icons.cancel,
          color: Colors.white,
        );
    }
  }

  Color colorStatus(String status) {
    switch (status) {
      case 'verified':
        return const Color(0xff13971E);
      case 'on_verification':
        return const Color(0xffF3F7FF);
      default:
        return const Color(0xffB51919);
    }
  }

  String titleStatus(String status) {
    switch (status) {
      case 'verified':
        return 'ПОДТВЕРЖДЕНО';
      case 'on_verification':
        return 'На проверке';
      default:
        return 'Не подтверждены';
    }
  }
}
