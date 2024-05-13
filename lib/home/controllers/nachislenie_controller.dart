import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';

import '../../app/common/components/snack_bar.dart';
import '../../app/user/models/pass_model.dart';
import '../../auth/models/permission_model4.dart';
import '../../challenge/data/promo_api.dart';
import '../../challenge/models/api_file_get_model.dart';
import '../../challenge/models/promo_model.dart';
import '../../challenge/views/screens/promo_success_screen.dart';
import '../../tests/models/test_model.dart';
import '../views/screens/pdf_faq_screen.dart';

class NachislenieController extends GetxController {
  bool isLoadingShare = false;
  bool isLoadingSendEmail = false;
  bool isLoadingSendFile = false;

  void loadingShare(bool loading) {
    isLoadingShare = loading;
    update();
  }

  void loadingSendEmail(bool loading) {
    isLoadingSendEmail = loading;
    update();
  }

  void loadingSendFile(bool loading) {
    isLoadingSendFile = loading;
    update();
  }

  Future showFile(context, String withdrawalId) async {
    loadingShare(true);
    ApiFileGetModel result = await ApiPromo.getPromoFiles(withdrawalId);
    print(result);
    if (result is ApiFileGetModel) {
      loadingShare(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewer(
            url: result.data.url,
          ),
        ),
      );
    }
  }

  Future sendEmail(context, String withdrawalId) async {
    loadingSendEmail(true);

    final result = await ApiPromo.sendEmail(withdrawalId);
    if (result == 'ok') {
      loadingSendEmail(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PromoSuccessScreen(
            mail: true,
            title: 'Акт отправлен на почту,\nуказанную в профиле',
          ),
        ),
      );
    } else {
      CustomSnackBar.badSnackBar(context, 'Ошибка, попробуйте позже');
    }
    loadingSendEmail(false);
  }

  List<File> selectedFiles = [];

  bool act = false;

  void getFile(context) async {
    showAlertDialog(context);
    update();
  }

  Future sendFile(context, String withdrawalId, PermissionModel4 model,
      PassModel passModel, PromoModel promoModel, TestModel testModel) async {
    loadingSendFile(true);
    final result = await ApiPromo.postAct(withdrawalId, selectedFiles);
    if (result == 'ok') {
      loadingSendFile(false);
      selectedFiles.clear();
      act = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PromoSuccessScreen(
            mail: false,
            withdrawalId: withdrawalId,
            title: 'Подтверждение акта\n занимает от 3х до 5ти дней',
            model: model,
            testModel: testModel,
            passModel: passModel,
            promoModel: promoModel,
          ),
        ),
      );
    } else {
      loadingSendFile(false);
      CustomSnackBar.badSnackBar(context, 'Ошибка, попробуйте позже');
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    String title = "Выберите источник фото";
    String cameraText = "Сделать фото";
    String galeryText = "Выбрать из галереи";
    String cancelText = "Файл";

    // set up the buttons
    Widget cameraButton = TextButton(
      child: Text(
        cameraText,
        style: const TextStyle(color: kGlobal),
      ),
      onPressed: () {
        _getFromCamera(context);
        Navigator.of(context).pop();
      },
    );

    Widget galeryButton = TextButton(
      child: Text(
        galeryText,
        style: const TextStyle(color: kGlobal),
      ),
      onPressed: () {
        _getFromGallery(context);
        Navigator.of(context).pop();
      },
    );

    Widget file = TextButton(
      child: Text(
        cancelText,
        style: const TextStyle(color: kGlobal),
      ),
      onPressed: () {
        _getFromFile(context);
        Navigator.of(context).pop();
      },
    );

    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 35,
                vertical: MediaQuery.of(context).size.height * 0.3),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: title,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Arial',
                    color: Color(0xff49536D),
                    size: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  cameraButton,
                  SizedBox(
                    height: 10,
                  ),
                  galeryButton,
                  SizedBox(
                    height: 10,
                  ),
                  file,
                ],
              ),
            ),
          );
        },
      );
    }

    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              child: CommonTextWidget(
                text: cameraText,
                color: kGlobal,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                _getFromCamera(context);
              },
            ),
            CupertinoDialogAction(
              child: CommonTextWidget(
                text: galeryText,
                color: kGlobal,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                _getFromGallery(context);
              },
            ),
            CupertinoDialogAction(
              child: CommonTextWidget(
                text: cancelText,
                color: kGlobal,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                _getFromFile(context);
              },
            ),
          ],
        ),
      );
    }
  }

  _getFromGallery(context) async {
    // ignore: deprecated_member_use
    File selectedFile;
    PickedFile result = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 15);
    if (result != null) {
      selectedFile = File(result.path);
      selectedFiles.add(selectedFile);
    } else {
      selectedFiles.clear();
      CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  /// Get from Camera
  _getFromCamera(context) async {
    // ignore: deprecated_member_us
    File selectedFile;
    PickedFile result = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 15);
    if (result != null) {
      selectedFile = File(result.path);
      selectedFiles.add(selectedFile);
    } else {
      selectedFiles.clear();
      CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  _getFromFile(context) async {
    File selectedFile;
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      selectedFile = File(result.files.single.path);
      selectedFiles.add(selectedFile);
    } else {
      selectedFiles.clear();
      CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }
}
