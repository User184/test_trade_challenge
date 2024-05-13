import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/covert_data_time.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/app/user/data/api_setting_user.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:teklub/auth/controller/reg_form_controller.dart';
import '/app/routes/route.dart' as route;

class PassportWidget extends StatelessWidget {
  PassportWidget(
      {Key key, this.isProfile = false, this.profileData, this.controller})
      : super(key: key);

  final GetProfileDataModel profileData;
  final bool isProfile;
  final GlobalKey<FormState> formKeyUserSettingsPassport =
      GlobalKey<FormState>();
  RegFormController controller;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return KeyboardDismisser(
        gestures: const [
          GestureType.onVerticalDragDown,
          GestureType.onVerticalDragStart,
        ],
        child: Scaffold(
          backgroundColor: kGlobalBlack,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 75),
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
                      child: GetBuilder<RegFormController>(
                          init: RegFormController(),
                          builder: (con) {
                            print(con.facePicker);
                            return Form(
                              key: formKeyUserSettingsPassport,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: fem * 30),
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromRGBO(
                                                        41, 44, 49, 0.12)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
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
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24),
                                          child: CommonTextWidget(
                                            text: 'Паспортные данные',
                                            size: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff404040),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          bottom: 25,
                                          top: 20),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        initialValue: profileData != null
                                            ? profileData.data.name
                                            : controller.firstName ?? "",
                                        // controller: isProfile
                                        //     ? (controller.firstNameController
                                        //       ..text = (controller
                                        //               .firstNameController
                                        //               .text
                                        //               .isEmpty
                                        //           ? profileData != null
                                        //               ? profileData.data.name
                                        //               : ''
                                        //           : controller
                                        //               .firstNameController.text)
                                        //       ..selection =
                                        //           TextSelection.collapsed(
                                        //               offset: controller
                                        //                   .firstNameController
                                        //                   .text
                                        //                   .length))
                                        //     : null,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Имя',
                                            hintText: 'Введите имя'),
                                        keyboardType: TextInputType.text,
                                        onChanged: (val) {
                                          controller.saveFirstName(val);
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.next,
                                        initialValue: profileData != null
                                            ? profileData.data.lastName
                                            : controller.secondName ?? "",

                                        // controller: isProfile
                                        //     ? (controller.secondNameController
                                        //       ..text = (controller
                                        //               .secondNameController
                                        //               .text
                                        //               .isEmpty
                                        //           ? profileData != null
                                        //               ? profileData
                                        //                   .data.lastName
                                        //               : ""
                                        //           : controller
                                        //               .secondNameController
                                        //               .text)
                                        //       ..selection =
                                        //           TextSelection.collapsed(
                                        //               offset: controller
                                        //                   .secondNameController
                                        //                   .text
                                        //                   .length))
                                        //     : null,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Фамилия',
                                            hintText: 'Введите фамилию'),
                                        keyboardType: TextInputType.text,
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.next,
                                        initialValue: profileData != null
                                            ? profileData.data.patronymic
                                            : controller.patranomic ?? "",
                                        // controller: isProfile
                                        //     ? (controller.lastNameController
                                        //       ..text = (controller
                                        //               .lastNameController
                                        //               .text
                                        //               .isEmpty
                                        //           ? profileData != null
                                        //               ? profileData
                                        //                   .data.patronymic
                                        //               : ""
                                        //           : controller
                                        //               .lastNameController.text)
                                        //       ..selection =
                                        //           TextSelection.collapsed(
                                        //               offset: controller
                                        //                   .lastNameController
                                        //                   .text
                                        //                   .length))
                                        //     : null,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Отчество',
                                            hintText: 'Введите отчество'),
                                        keyboardType: TextInputType.text,
                                        onSaved: (val) {
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
                                        // enabled: false,
                                        style: const TextStyle(
                                            color: Color(0xff49536D)),
                                        controller: isProfile
                                            ? (controller.dateOfBirthController
                                              ..text = (controller
                                                      .dateOfBirthController
                                                      .text
                                                      .isEmpty
                                                  ? profileData != null &&
                                                          profileData
                                                                  .data
                                                                  .passportData
                                                                  .dateOfBirth !=
                                                              null
                                                      ? convertDataTime(
                                                          DateTime.parse(
                                                              profileData
                                                                  .data
                                                                  .passportData
                                                                  .dateOfBirth))
                                                      : ""
                                                  : controller
                                                      .dateOfBirthController
                                                      .text)
                                              ..selection =
                                                  TextSelection.collapsed(
                                                      offset: controller
                                                          .dateOfBirthController
                                                          .text
                                                          .length))
                                            : null,
                                        inputFormatters: [controller.birthDay],
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            suffixIcon: SizedBox(
                                              width:
                                                  20, // Adjust the width as needed
                                              height:
                                                  20, // Adjust the height as needed
                                              child: Transform.scale(
                                                scale:
                                                    0.6, // Adjust the scale factor as needed
                                                child: SvgPicture.asset(
                                                  'assets/images/calendar.svg',
                                                ),
                                              ),
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Дата рождения',
                                            hintText: 'дд.мм.гггг'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) {
                                          controller.savePassDate2(val);
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        inputFormatters: [
                                          controller.maskSeriesNumber
                                        ],
                                        controller: controller
                                            .passportSeriesController
                                          ..text = (controller
                                                  .passportSeriesController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData.data
                                                      .passportData.seriesNumber
                                                  : ''
                                              : controller
                                                  .passportSeriesController
                                                  .text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .passportSeriesController
                                                  .text
                                                  .length),
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Серия паспорта',
                                            hintText: 'Введите серию паспорта'),
                                        keyboardType: TextInputType.phone,
                                        onSaved: (val) {
                                          controller.savePassportSeries(val);
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 4) {
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
                                        inputFormatters: [
                                          controller.maskNumberPassport
                                        ],
                                        textInputAction: TextInputAction.next,
                                        controller: controller
                                            .numberPassportController
                                          ..text = (controller
                                                  .numberPassportController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData
                                                      .data
                                                      .passportData
                                                      .passportNumber
                                                  : ''
                                              : controller
                                                  .numberPassportController
                                                  .text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .numberPassportController
                                                  .text
                                                  .length),
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Номер паспорта',
                                            hintText: 'Введите номер паспорта'),
                                        keyboardType: TextInputType.phone,
                                        onSaved: (val) {
                                          controller.savePassportNumber(val);
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 6) {
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
                                        controller: controller
                                            .codeVeshController
                                          ..text = (controller
                                                  .codeVeshController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData.data
                                                      .passportData.issuedBy
                                                  : ''
                                              : controller
                                                  .codeVeshController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .codeVeshController
                                                  .text
                                                  .length),
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Кем выдан',
                                            hintText:
                                                'Пример заполнения: ТП№1 ОУФМС'),
                                        keyboardType: TextInputType.text,
                                        onChanged: (val) {
                                          controller.saveKemVidan(val);
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
                                        controller: controller
                                            .dateOfIssueController
                                          ..text = (controller
                                                  .dateOfIssueController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null &&
                                                      profileData
                                                              .data
                                                              .passportData
                                                              .dateOfIssue !=
                                                          null
                                                  ? convertDataTime(
                                                      DateTime.parse(profileData
                                                          .data
                                                          .passportData
                                                          .dateOfIssue))
                                                  : ""
                                              : controller
                                                  .dateOfIssueController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .dateOfIssueController
                                                  .text
                                                  .length),
                                        inputFormatters: [controller.dataVish],
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            suffixIcon: SizedBox(
                                              width:
                                                  20, // Adjust the width as needed
                                              height:
                                                  20, // Adjust the height as needed
                                              child: Transform.scale(
                                                scale:
                                                    0.6, // Adjust the scale factor as needed
                                                child: SvgPicture.asset(
                                                  'assets/images/calendar.svg',
                                                ),
                                              ),
                                            ),
                                            labelText: 'Дата выдачи паспорта',
                                            hintText: 'дд.мм.гггг'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) {
                                          controller.savePassDate1(val);
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: controller
                                            .codeDivisionController
                                          ..text = (controller
                                                  .codeDivisionController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData
                                                      .data
                                                      .passportData
                                                      .subdivisionCode
                                                  : ''
                                              : controller
                                                  .codeDivisionController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .codeDivisionController
                                                  .text
                                                  .length),
                                        inputFormatters: [controller.maskCode],
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Код подразделения',
                                            hintText: 'Пример: 111-111'),
                                        keyboardType: TextInputType.phone,
                                        onSaved: (val) {
                                          controller.saveCodeDivision(val);
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 7) {
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
                                        controller: controller
                                            .birthPlaceController
                                          ..text = (controller
                                                  .birthPlaceController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData.data
                                                      .passportData.placeOfBirth
                                                  : ''
                                              : controller
                                                  .birthPlaceController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .birthPlaceController
                                                  .text
                                                  .length),
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Место рождения',
                                            hintText: 'Введите место рождения'),
                                        keyboardType: TextInputType.text,
                                        onSaved: (val) {
                                          controller.saveBirthPlace(val);
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
                                        inputFormatters: [controller.dataReg],
                                        style: const TextStyle(
                                            color: Color(0xff49536D)),
                                        controller: controller.regController
                                          ..text = (controller
                                                  .regController.text.isEmpty
                                              ? profileData != null &&
                                                      profileData
                                                              .data
                                                              .passportData
                                                              .dateOfRegistration !=
                                                          null
                                                  ? convertDataTime(
                                                      DateTime.parse(profileData
                                                          .data
                                                          .passportData
                                                          .dateOfRegistration))
                                                  : ""
                                              : controller.regController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .regController.text.length),
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            suffixIcon: SizedBox(
                                              width:
                                                  20, // Adjust the width as needed
                                              height:
                                                  20, // Adjust the height as needed
                                              child: Transform.scale(
                                                scale:
                                                    0.6, // Adjust the scale factor as needed
                                                child: SvgPicture.asset(
                                                  'assets/images/calendar.svg',
                                                ),
                                              ),
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Дата регистрации',
                                            hintText: 'дд.мм.гггг'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) {
                                          controller.savePassDate3(val);
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.next,
                                        controller: controller
                                            .registrationPlaceController
                                          ..text = (controller
                                                  .registrationPlaceController
                                                  .text
                                                  .isEmpty
                                              ? profileData != null
                                                  ? profileData
                                                      .data
                                                      .passportData
                                                      .placeOfRegistration
                                                  : ''
                                              : controller
                                                  .registrationPlaceController
                                                  .text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .registrationPlaceController
                                                  .text
                                                  .length),
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Место регистрации',
                                            hintText:
                                                'Введите место регистрации'),
                                        keyboardType: TextInputType.text,
                                        onSaved: (val) {
                                          controller.saveRegistrationPlace(val);
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
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: controller.innController
                                          ..text = (controller
                                                  .innController.text.isEmpty
                                              ? profileData != null
                                                  ? profileData.data.inn
                                                  : ''
                                              : controller.innController.text)
                                          ..selection = TextSelection.collapsed(
                                              offset: controller
                                                  .innController.text.length),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(12),
                                        ],
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'ИНН',
                                            hintText: 'Например: 1231123123'),
                                        keyboardType: TextInputType.phone,
                                        onSaved: (val) {
                                          controller.saveInn(context, val);
                                        },
                                        validator: (value) {
                                          if (value.length < 12) {
                                            return 'Заполните поле';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25, bottom: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: CommonTextWidget(
                                                  text: 'Фото лицевой стороны',
                                                  size: 14,
                                                  fontFamily:
                                                      'SFProTextRegular',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff131313),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              (profileData != null &&
                                                              (profileData.data
                                                                          .passportData !=
                                                                      null &&
                                                                  profileData
                                                                          .data
                                                                          .passportData
                                                                          .passportFront !=
                                                                      null &&
                                                                  profileData
                                                                      .data
                                                                      .passportData
                                                                      .passportFront
                                                                      .last
                                                                      .url
                                                                      .isNotEmpty) ||
                                                          (con.facePicker !=
                                                              null)) &&
                                                      !con.removefacePicker
                                                  ? SizedBox(
                                                      height: 150,
                                                      width: double.infinity,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Center(
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.2,
                                                              // height: 92,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: con.facePicker ==
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        profileData
                                                                            .data
                                                                            .passportData
                                                                            .passportFront
                                                                            .last
                                                                            .url,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      )
                                                                    : Image
                                                                        .file(
                                                                        con.facePicker,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () => con
                                                                .removeFacePicker(
                                                                    context),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          242,
                                                                          224,
                                                                          224),
                                                              radius: 15,
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/images/cancel1.svg'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        await con.getPhotos(
                                                            context, 0);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: const Color(
                                                              0xffF9F9F9),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xff1D1D1D)
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 0,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 25,
                                                                  bottom: 25),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      spreadRadius:
                                                                          0,
                                                                      blurRadius:
                                                                          0,
                                                                      color: const Color(
                                                                              0xff0025C2)
                                                                          .withOpacity(
                                                                              0.1),
                                                                    ),
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .local_see,
                                                                      color: Color(
                                                                          0xffED1D24)),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 24),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: const [
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          CommonTextWidget(
                                                                        text:
                                                                            'Загрузить',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        size:
                                                                            16,
                                                                        color: Color(
                                                                            0xff131313),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          CommonTextWidget(
                                                                        text:
                                                                            'Не более 2 мб',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        size:
                                                                            14,
                                                                        color: Color(
                                                                            0xff8793B4),
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
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25, bottom: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: CommonTextWidget(
                                                  text: 'Фото регистрации',
                                                  size: 14,
                                                  fontFamily:
                                                      'SFProTextRegular',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff131313),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              (profileData != null &&
                                                              (profileData.data
                                                                          .passportData !=
                                                                      null &&
                                                                  profileData
                                                                          .data
                                                                          .passportData
                                                                          .passportAddress !=
                                                                      null &&
                                                                  profileData
                                                                      .data
                                                                      .passportData
                                                                      .passportAddress
                                                                      .last
                                                                      .url
                                                                      .isNotEmpty) ||
                                                          (con.regPicker !=
                                                              null)) &&
                                                      !con.removeregPicker
                                                  ? SizedBox(
                                                      height: 150,
                                                      width: double.infinity,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Center(
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.2,
                                                              // height: 92,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: con.regPicker ==
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        profileData
                                                                            .data
                                                                            .passportData
                                                                            .passportAddress
                                                                            .last
                                                                            .url,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      )
                                                                    : Image
                                                                        .file(
                                                                        con.regPicker,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () => con
                                                                .removeRegPicker(
                                                                    context),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffEB4F4F),
                                                              radius: 15,
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/images/cancel1.svg'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        await con.getPhotos(
                                                            context, 1);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: const Color(
                                                              0xffF9F9F9),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xff1D1D1D)
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 0,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 25,
                                                                  bottom: 25),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      spreadRadius:
                                                                          0,
                                                                      blurRadius:
                                                                          0,
                                                                      color: const Color(
                                                                              0xff0025C2)
                                                                          .withOpacity(
                                                                              0.1),
                                                                    ),
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .local_see,
                                                                    color: Color(
                                                                        0xffED1D24),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 24),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: const [
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          CommonTextWidget(
                                                                        text:
                                                                            'Загрузить',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        size:
                                                                            16,
                                                                        color: Color(
                                                                            0xff131313),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          CommonTextWidget(
                                                                        text:
                                                                            'Не более 2 мб',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        size:
                                                                            14,
                                                                        color: Color(
                                                                            0xff8793B4),
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
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          top: 25,
                                          right: 25),
                                      child: Opacity(
                                        opacity: formKeyUserSettingsPassport
                                                        .currentState !=
                                                    null &&
                                                !formKeyUserSettingsPassport
                                                    .currentState
                                                    .validate()
                                            ? 0.4
                                            : 1,
                                        child: Material(
                                          elevation: controller.loading != true
                                              ? 3
                                              : 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          color: kGlobal,
                                          child: InkWell(
                                            onTap: () async {
                                              // formKeyUserSettingsPassport.currentState
                                              //     .save();
                                              // print('object');
                                              controller.regPicker =
                                                  con.regPicker;
                                              controller.facePicker =
                                                  con.facePicker;
                                              controller.update();

                                              // Navigator.pop(context);
                                              if (formKeyUserSettingsPassport
                                                  .currentState
                                                  .validate()) {
                                                if ((con.regPicker != null &&
                                                        con.facePicker !=
                                                            null) ||
                                                    (profileData != null &&
                                                        (profileData.data
                                                                    .passportData !=
                                                                null &&
                                                            profileData
                                                                    .data
                                                                    .passportData
                                                                    .passportAddress !=
                                                                null &&
                                                            profileData
                                                                .data
                                                                .passportData
                                                                .passportAddress
                                                                .last
                                                                .url
                                                                .isNotEmpty) &&
                                                        (profileData.data
                                                                    .passportData !=
                                                                null &&
                                                            profileData
                                                                    .data
                                                                    .passportData
                                                                    .passportFront !=
                                                                null &&
                                                            profileData
                                                                .data
                                                                .passportData
                                                                .passportFront
                                                                .last
                                                                .url
                                                                .isNotEmpty))) {
                                                  formKeyUserSettingsPassport
                                                      .currentState
                                                      .save();
                                                  if (isProfile) {
                                                    await ApiSettingUser
                                                        .setSpecsAndPromoCode([
                                                      controller.inn ?? ""
                                                    ], isInn: true);
                                                    await controller
                                                        .putPassportProfileData();
                                                    Navigator.pushReplacementNamed(
                                                        context,
                                                        route
                                                            .userSettingsScreen);
                                                    return;
                                                  } else {
                                                    Navigator.pop(context);
                                                  }
                                                  controller
                                                      .changeStatusPassport(
                                                          true);
                                                }
                                              }
                                            },
                                            child: SizedBox(
                                              height: 70,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const CommonTextWidget(
                                                      text: 'Сохранить',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      size: 16,
                                                    ),
                                                    controller.loadingPassport ==
                                                            true
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
              ),
            ],
          ),
        ));
  }
}

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: status == 'verified'
            ? const Color(0xff1FCED7)
            : status == 'on_verification'
                ? Colors.grey[300]
                : const Color(0xffF29200),
      ),
      width: 160,
      height: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: status == 'verified'
                    ? const Icon(
                        Icons.check,
                        color: Color(0xff1FCED7),
                      )
                    : status == 'on_verification'
                        ? const Icon(
                            Icons.timer,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.close,
                            color: Color(0xffF29200),
                          ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: CommonTextWidget(
                  text: status == 'verified'
                      ? 'Подтверждено'
                      : status == 'on_verification'
                          ? 'На проверке'
                          : 'Не подтверждено',
                  size: 14,
                  color: status == 'on_verification'
                      ? const Color(0xff8793B4)
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
