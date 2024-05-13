import 'dart:async';
import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/auth/data/api_service.dart';
import 'package:teklub/auth/models/register_model.dart';
import 'package:teklub/auth/models/success_register_model.dart';

import '/app/routes/route.dart' as route;
import '../../app/common/components/common_text_widget.dart';
import '../../app/common/components/covert_data_time.dart';
import '../../app/user/data/api_setting_user.dart';
import '../../app/user/models/get_profile_data_model.dart';
import '../models/specs_model.dart';
import 'auth_controller.dart';

enum PageName { Home, Profile, Reg }

class RegFormController extends GetxController {
  final AuthController authController = Get.put(AuthController());

  final GlobalKey<FormState> formKeyReg = GlobalKey<FormState>();
  final GlobalKey<FormState> userKeyReg = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyReg2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUserSettingsPassport =
      GlobalKey<FormState>();

  final maskFormatter1 = MaskTextInputFormatter(mask: '+7 (###) ###-##-##');
  final birthDay = MaskTextInputFormatter(mask: '##.##.####');
  final dataReg = MaskTextInputFormatter(mask: '##.##.####');
  final dataVish = MaskTextInputFormatter(mask: '##.##.####');

  bool checkbox = false;
  bool checkbox2 = false;
  RxBool checkbox1 = RxBool(false);

  final promoController = TextEditingController();

  checkBoxUpdate(val) {
    checkbox = val;
    update();
  }

  void inputPromoCode(String promo) {
    promoController.text = promo;
    update();
  }

  checkBoxUpdate2(val) {
    checkbox2 = val;
    update();
  }

  bool loading = false;

  toggleLoading() {
    loading = !loading;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String birthPlace;

  void saveBirthPlace(val) {
    birthPlace = val;
    update();
  }

  String registrationPlace;

  void saveRegistrationPlace(val) {
    registrationPlace = val;
    update();
  }

  List<List<String>> positionList = [];
  String savedPosition;
  String savedPositionId;

  bool purchaser = true;
  List selectedId = [];
  void saveSpes(String val, List<SpecsModel> specializations) {
    selectedId = [];
    savedPosition = val;
    specializations.forEach((element) {
      print('object');
      if (element.name.toLowerCase() == val.toLowerCase()) {
        selectedId.add(element.id);
      }
    });
    update();
  }

  void officePositionId(List<List<String>> pos) {
    pos.forEach((element) {
      savedPositionId = element[0].toString();
    });
  }

  List<SpecsModel> dataSpecs = [];
  List<SpecsModel> dataSpecsLocal = [];

  GetStorage storage = GetStorage();

  List tradePintNameList = [];
  List tradePintCityList = [];
  List tradePintAddressList = [];
  String savedTradePintName;
  String savedTradePintCity;
  String savedTradePintAddress;
  final maskNumberPassport = MaskTextInputFormatter(mask: '######');
  final maskSeriesNumber = MaskTextInputFormatter(mask: '####');
  final maskCode = MaskTextInputFormatter(mask: '###-###');

  //TextEditingController controllerPromoCode = TextEditingController();

  void saveTradePintName(String val) {
    savedTradePintName = val;
    update();
  }

  void saveTradePintCity(String val) {
    savedTradePintCity = val;
    update();
  }

  void saveTradePintAddress(String val) {
    savedTradePintAddress = val;
    update();
  }

  String patranomicName;

  void savepatranomicName(val) {
    patranomicName = val;
    print('object');
    update();
  }

  String passportNumber;

  void savePassportNumber(val) {
    passportNumber = val;
    update();
  }

  String passportSeries;

  void savePassportSeries(val) {
    passportSeries = val;
    update();
  }

  String firstName;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();

  final TextEditingController dateOfIssueController = TextEditingController();
  final TextEditingController regController = TextEditingController();
  final TextEditingController passportSeriesController =
      TextEditingController();
  final TextEditingController codeDivisionController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController innController = TextEditingController();
  final TextEditingController codeVeshController = TextEditingController();
  final TextEditingController registrationPlaceController =
      TextEditingController();
  final TextEditingController issuedByController = TextEditingController();
  final TextEditingController numberPassportController =
      TextEditingController();
  final TextEditingController placeOfRegistrationController =
      TextEditingController();

  Future<void> selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (type == 'bir') {
        dateOfBirthController.text = convertDataTime(picked);
      } else if (type == 'reg') {
        regController.text = convertDataTime(picked);
      } else {
        dateOfIssueController.text = convertDataTime(picked);
      }
    }
    update();
  }

  String kemVidan;

  void saveKemVidan(val) {
    kemVidan = val;
    update();
  }

  String codeDivision;
  String passDate1;

  void saveCodeDivision(val) {
    codeDivision = val;
    update();
  }

  void savePassDate1(val) {
    passDate1 = val;
    update();
  }

  String passDate2;

  void savePassDate2(val) {
    passDate2 = val;
    update();
  }

  String passDate3;

  void savePassDate3(val) {
    passDate3 = val;
    update();
  }

  File facePicker;
  void removeFacePicker(context, {isReg = true}) async {
    if (isReg) {
      facePicker = null;
      removefacePicker = true;
    } else {
      final res = await ApiSettingUser.deletePhotosPassport('passport_front');
      if (res is Success) {
        facePicker = null;
        removefacePicker = true;
      } else {
        CustomSnackBar.badSnackBar(context, 'Ошибка запроса.');
      }
    }
    update();
  }

  bool photoUploaded = false;

  File regPicker;
  void removeRegPicker(context, {isReg = true}) async {
    if (isReg) {
      regPicker = null;
      removeregPicker = true;
    } else {
      final res = await ApiSettingUser.deletePhotosPassport('passport_address');
      if (res is Success) {
        regPicker = null;
        removeregPicker = true;
      } else {
        CustomSnackBar.badSnackBar(context, 'Ошибка запроса.');
      }
    }

    update();
  }

  bool removefacePicker = false;
  bool removeregPicker = false;
  Future<File> testCompressAndGetFile(String path, String targetP) async {
    final directory = await getTemporaryDirectory();
    final targetPath = directory.path + targetP;
    var result = await FlutterImageCompress.compressAndGetFile(path, targetPath,
        quality: 80, minHeight: 1000, minWidth: 1000);
    return File(result.path);
  }

  bool errorPoint = false;
  void errorPointUpdate(bool val) {
    errorPoint = val;
    update();
  }

  Future getPhotos(context, int index) async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      if (index == 0) {
        facePicker = await testCompressAndGetFile(
            result.files.single.path, result.files.single.path.split('/').last);
        if (regPicker != null) photoUploaded = true;
        removefacePicker = false;
      } else {
        regPicker = await testCompressAndGetFile(
            result.files.single.path, result.files.single.path.split('/').last);
        if (facePicker != null) photoUploaded = true;
        removeregPicker = false;
      }
    } else {
      CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  bool loadingPassport = false;

  toLoadingPassport() {
    loadingPassport = !loadingPassport;
    update();
  }

  Future<GetProfileDataModel> putPassportProfileData() async {
    toLoadingPassport();

    GetProfileDataModel result = await ApiSettingUser.postProfileData(
      SendPassportRequestModel(
          passportNumber: passportNumber ?? numberPassportController.text,
          seriesNumber: passportSeries ?? passportSeriesController.text,
          dateOfIssue: passDate1 ?? dateOfIssueController.text,
          subdivisionCode: codeDivision ?? codeVeshController.text,
          issuedBy: kemVidan ?? issuedByController.text,
          dateOfBirth: passDate2 ?? dateOfBirthController.text,
          placeOfBirth: birthPlace ?? placeOfBirthController.text,
          dateOfRegistration: passDate3 ?? regController.text,
          placeOfRegistration:
              registrationPlace ?? placeOfRegistrationController.text,
          passportData: [facePicker, regPicker],
          // passportFront: '',
          // passportAddress: '',
          name: firstName ?? firstNameController.text,
          // inn: inn,
          lastName: secondName ?? secondNameController.text,
          patranomic: patranomic ?? lastNameController.text),
    ).whenComplete(() => toLoadingPassport());

    update();
    return result;
  }

  String getChoesedSpecs() {
    String specsData = '';
    for (int i = 0; i < dataSpecs.length; i++) {
      if (dataSpecs[i].select) {
        specsData += dataSpecs[i].name + ',';
      }
    }
    return specsData;
  }

  Future getSpecs(context) async {
    await APIServiceAuth.getSpecial().then((value) async {
      if (value is DataSpecs) {
        updateSpecs(value.data);
      } else if (value is ErrorRequestSpecs) {
        CustomSnackBar.badSnackBar(context, value.error);
      }
    });
  }

  Future getSpecsFromAuth() async {
    List value = authController.specs;
    if (value is List<SpecsModel>) {
      updateSpecs(value);
    }
  }

  void updateSpecs(List<SpecsModel> value) async {
    dataSpecs = [];
    selectedId = await storage.read('CACHEDSPECS') ?? [];
    for (int i = 0; i < value.length; i++) {
      var model = SpecsModel(
        select: false,
        id: value[i].id,
        many: value[i].many,
        name: value[i].name,
      );
      if (selectedId != null) {
        for (var item in selectedId) {
          if (item == value[i].id) model.select = true;
        }
      }
      dataSpecs.add(model);
    }
  }

  void checkBox(int index) async {
    if (dataSpecs[index].many == false) {
      setAllFalse();
      selectedId.add(dataSpecs[index].id);
      dataSpecs[index].select = !dataSpecs[index].select;
    } else {
      for (int i = 0; i < dataSpecs.length; i++) {
        if (dataSpecs[i].select && !dataSpecs[i].many) {
          setAllFalse();
        }
      }
      dataSpecs[index].select = !dataSpecs[index].select;
      if (dataSpecs[index].select) {
        print(dataSpecs[index].id);
        selectedId.add(dataSpecs[index].id);
      } else {
        selectedId.remove(dataSpecs[index].id);
      }
    }

    update();
  }

  void setAllFalse() {
    for (int i = 0; i < dataSpecs.length; i++) {
      dataSpecs[i].select = false;
    }
    selectedId = [];
  }

  String regionID;
  bool isPosition = false;

  void sendReg(context) async {
    if (savedPositionId.isEmpty) {
      isPosition = true;
      update();
      return;
    }
    isPosition = false;
    print('object$savedPositionId');
    if (formKeyReg.currentState.validate()) {
      formKeyReg.currentState.save();

      toggleLoading();
      final res = await successUserRegisterCheck();
      if (res is SuccessRegisterResponseModel) {
        GetStorage storage = GetStorage();
        await storage.write('domen', res.accessDomain);
        print('MMMMM${storage.read('domen')}');
        print('vfv${res.accessDomain}');

        await AppMetrica.reportEventWithMap(
            'save_check', {'save_check': 'save_check'});
        await ApiSettingUser.setSpecsAndPromoCode(selectedId);
        await ApiSettingUser.setSpecsAndPromoCode([inn], isInn: true);
        if (passportDone && regPicker != null && facePicker != null) {
          await putPassportProfileData();
        }

        toggleLoading();
        Navigator.pushReplacementNamed(context, route.welcomeScreen);
      } else if (res is ErrorRequestRegisterSuccess) {
        toggleLoading();
        if (res.errors.tradePointInn != null) {
          bool errorPoint = false;
          errorPointUpdate(true);
          showAlertDialogMKCode(context);
        } else {
          errorPointUpdate(false);
          CustomSnackBar.badSnackBar(context, res.errors.message);
        }
        print(res.errors.tradePointInn);
        // if(res)

        //
      }
    }
    // toggleLoading();
    update();
  }

  bool passportDone = false;

  void changeStatusPassport(bool val) {
    passportDone = val;
    update();
  }

  showAlertDialogMKCode(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: MediaQuery.of(context).size.height * 0.25),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/bad1.svg',
                  color: Color(0xffB51919),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CommonTextWidget(
                  textAlign: TextAlign.center,
                  text: 'Неверный МК - код',
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arial',
                  color: Color(0xff49536D),
                  size: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CommonTextWidget(
                    textAlign: TextAlign.center,
                    text:
                        'Исправьте его или обратитесь к своему торговому представителю',
                    fontWeight: FontWeight.normal,
                    color: Color(0xff49536D),
                    size: 15,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kGlobal)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const CommonTextWidget(
                      text: 'Хорошо',
                      fontWeight: FontWeight.w700,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogPromoCode(context) async {
    final size = MediaQuery.of(context).size;
    FocusNode f1 = FocusNode();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    await showDialog(
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: size.height * .4,
            top: size.height * .2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: GestureDetector(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(41, 44, 49, 0.12),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Color(0xff8793B4),
                            size: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        sendReg(context);
                      },
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      text: 'Введите промокод друга',
                      fontWeight: FontWeight.w400,
                      size: 19,
                      overflow: TextOverflow.fade,
                      color: ThemeSettings.primaryColorText,
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.height * .1,
                      child: Material(
                        child: TextField(
                          focusNode: f1,
                          controller: promoController,
                          decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xff8793B4)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .003,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () async {
                          inputPromoCode(promoController.text);
                          Navigator.pop(context);
                          sendReg(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff3C6FE4),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: size.width * 0.6,
                          child: const Center(
                            child: CommonTextWidget(
                              text: 'Хорошо',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveFirstName(val) {
    firstName = val;
    update();
  }

  // void savePosition(val) {
  //   firstName = val;
  // }

  String secondName;

  void saveSecondName(val) {
    secondName = val;
    update();
  }

  String patranomic;

  void savePatranomic(val) {
    patranomic = val;
    update();
  }

  String phone;

  void savePhone(val) {
    phone = val;
  }

  String email;

  void saveEmail(val) {
    email = val;
    update();
  }

  String city;

  void saveCity(val) {
    city = val;
  }

  String mkCode;
  void saveMkCode(val) {
    mkCode = val;
    update();
  }

  String inn;

  RxBool loadingRequest = RxBool(false);

  void saveInn(context, val) async {
    print('valvalvalval${val}');
    inn = val;
    update();
  }

  List storeNameList = [];
  String storeName;

  void saveStoreName(val) {
    storeName = val;
  }

  List cityList = [];

  List addressStoreList = [];
  String addressStore;

  void saveAddressStore(val) {
    addressStore = val;
  }

  Future<RegisterAuth> userRegisterCheck() async {
    RegisterAuth result = await APIServiceAuth.regFormCheck(
      RegisterRequestModel(
        slug: authController.companyName,
        phone: authController.phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
        promoCode: authController.promoCode,
        password: authController.smsPass,
        name: firstName,
        lastName: secondName,
        patronymic: patranomic,
        email: email.trim(),
        officePositionId: savedPositionId,
        inn: purchaser ? mkCode : "000000",
      ),
    );
    return result;
  }

  String tradePointName = 'ООО \"Пример\"';
  String tradePointCity = 'Москва';
  String tradePointAddress = 'Москва';

  Future getInfoReg() async {
    RegisterAuth res = await userRegisterCheck();
    if (res is RegisterResponseModel) {
      tradePointName = res.tradePointName[0];
      tradePointCity = res.tradePointCity[0];
      tradePointAddress = res.tradePointAddress[0];
    }
  }

  Future<RegisterAuth> successUserRegisterCheck() async {
    await getInfoReg();
    RegisterAuth result = await APIServiceAuth.successRegFormCheck(
      SuccessRegisterRequestModel(
        slug: authController.companyName,
        phone: authController.phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
        promoCode: authController.promoCode,
        password: authController.smsPass,
        name: firstName,
        lastName: secondName,
        patronymic: patranomic,
        email: email.trim(),
        officePositionId: savedPositionId,
        mkCode: purchaser ? mkCode : "000000",
        inn: inn,
        tradePointName: tradePointName,
        tradePointCity: tradePointCity,
        tradePointAddress: tradePointAddress,
        // os: authController.osVersion,
        // version: authController.platform,
        // deviceToken: 'test',
        // regionId: 1,
        // city: "kazan"
      ),
    );
    return result;
  }

  // RxBool successLoading = RxBool(false);
  //
  // Future<RegisterAuth> successRegister() async {
  //   successLoading.value = true;
  //   var res = await successUserRegisterCheck();
  //   if (res is SuccessRegisterResponseModel) {
  //     print(res.message);
  //     successLoading.value = false;
  //     return res;
  //   } else if (res is ErrorRequestRegister) {
  //     successLoading.value = false;
  //     print(res.error);
  //     return res;
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    positionList = authController.officePositions;
    savePhone(authController.phoneNumber);
  }
}
