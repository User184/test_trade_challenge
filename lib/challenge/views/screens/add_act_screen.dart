import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/challenge/views/screens/promo_success_screen.dart';

import '../../../app/common/components/snack_bar.dart';
import '../../../app/user/models/pass_model.dart';
import '../../../auth/models/permission_model4.dart';
import '../../../home/views/screens/pdf_faq_screen.dart';
import '../../../tests/models/test_model.dart';
import '../../data/promo_api.dart';
import '../../models/api_file_get_model.dart';
import '../../models/file_model.dart';
import '../../models/promo_model.dart';

class AddActScreen extends StatefulWidget {
  final String withdrawalId;
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;

  const AddActScreen(
      {Key key,
      this.withdrawalId,
      this.testModel,
      this.promoModel,
      this.passModel,
      this.model})
      : super(key: key);

  @override
  _AddActScreenState createState() => _AddActScreenState();
}

class _AddActScreenState extends State<AddActScreen> {
  List<FileModel> filesList = [];

  bool loading = false;
  bool mailLoading = false;
  bool actSendLoading = false;

  List<File> selectedFiles = [];

  void getFile() async {
    File selectedFile;
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedFile = File(result.files.single.path);
      setState(() {
        selectedFiles.add(selectedFile);
      });
    } else {
      CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGlobal,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: const CommonTextWidget(
          text: 'Загрузка акта',
          fontWeight: FontWeight.bold,
          size: 20,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kGlobal,
        centerTitle: true,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CommonTextWidget(
                          text: '1. Проверьте акт',
                          fontWeight: FontWeight.normal,
                          size: 16,
                          color: Color(0xff49536D),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CommonTextWidget(
                            text: '2. Подпишите акт',
                            fontWeight: FontWeight.normal,
                            size: 16,
                            color: Color(0xff49536D),
                          ),
                        ),
                        CommonTextWidget(
                          text: '3. Загрузите фото или PDF подписанного акта ',
                          fontWeight: FontWeight.normal,
                          size: 16,
                          color: Color(0xff49536D),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.insert_drive_file,
                              color: kGlobal,
                            ),
                            title: const CommonTextWidget(
                              text: 'Посмотреть акт',
                              fontWeight: FontWeight.bold,
                              size: 17,
                              color: kGlobal,
                            ),
                            onTap: () async {
                              ApiFileGetModel result =
                                  await ApiPromo.getPromoFiles(
                                      widget.withdrawalId);
                              if (result is ApiFileGetModel) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewer(
                                      url: result.data.url,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ListTile(
                              onTap: mailLoading == true
                                  ? null
                                  : () async {
                                      setState(() {
                                        mailLoading = true;
                                      });

                                      final result = await ApiPromo.sendEmail(
                                          widget.withdrawalId);
                                      if (result == 'ok') {
                                        setState(() {
                                          mailLoading = false;
                                        });

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PromoSuccessScreen(
                                                    withdrawalId:
                                                        widget.withdrawalId,
                                                    mail: false,
                                                    title:
                                                        'Акт отправлен на проверку',
                                                    model: widget.model,
                                                    passModel: widget.passModel,
                                                    promoModel:
                                                        widget.promoModel,
                                                    testModel:
                                                        widget.testModel),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          mailLoading = false;
                                        });
                                        CustomSnackBar.badSnackBar(context,
                                            'Ошибка, попробуйте позже');
                                      }
                                    },
                              leading: mailLoading == true
                                  ? const SizedBox(
                                      width: 17,
                                      height: 17,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Icon(Icons.email, color: kGlobal),
                              title: const CommonTextWidget(
                                text: 'Отправить акт на почту',
                                fontWeight: FontWeight.bold,
                                size: 17,
                                color: kGlobal,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              getFile();
                            },
                            leading:
                                const Icon(Icons.attach_file, color: kGlobal),
                            title: const CommonTextWidget(
                              text: 'Загрузить подписанный акт',
                              fontWeight: FontWeight.bold,
                              size: 17,
                              color: kGlobal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selectedFiles.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            color: Colors.grey[200],
                            child: ListView(
                              children: selectedFiles
                                  .map(
                                    (e) => ListTile(
                                      leading: const Icon(Icons.attach_file),
                                      title: SizedBox(
                                        width: 60.w,
                                        child: CommonTextWidget(
                                          overflow: TextOverflow.ellipsis,
                                          text: e.path.split('/').last,
                                          fontWeight: FontWeight.normal,
                                          size: 14,
                                          color: kGlobal,
                                        ),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedFiles.removeWhere(
                                                (element) => element == e);
                                          });
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    if (selectedFiles.isEmpty) const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          bottom: MediaQuery.of(context).size.height * 0.05,
                          right: 25,
                          top: 15),
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: selectedFiles.isEmpty
                            ? Colors.grey
                            : kGlobal, //,const Color(0xff3C6FE4),
                        child: InkWell(
                          onTap: actSendLoading == true || selectedFiles.isEmpty
                              ? null
                              : () async {
                                  setState(() {
                                    actSendLoading = true;
                                  });
                                  final result = await ApiPromo.postAct(
                                      widget.withdrawalId, selectedFiles);
                                  if (result == 'ok') {
                                    setState(() {
                                      actSendLoading = false;
                                    });
                                    selectedFiles.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PromoSuccessScreen(
                                                mail: false,
                                                title:
                                                    'Акт отправлен на проверку',
                                                withdrawalId:
                                                    widget.withdrawalId,
                                                model: widget.model,
                                                passModel: widget.passModel,
                                                promoModel: widget.promoModel,
                                                testModel: widget.testModel),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      actSendLoading = false;
                                    });
                                    CustomSnackBar.badSnackBar(
                                        context, 'Ошибка, попробуйте позже');
                                  }
                                },
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CommonTextWidget(
                                    text: 'Отправить на проверку',
                                    fontWeight: FontWeight.w700,
                                    size: 16,
                                  ),
                                  actSendLoading == false
                                      ? const Padding(
                                          padding: EdgeInsets.only(bottom: 7),
                                          child: SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(
                                            color: kGlobal,
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
