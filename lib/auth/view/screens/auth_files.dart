import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/auth/controller/auth_controller.dart';
import 'package:teklub/home/views/widgets/faq_widgets/faq_file_widget.dart';

class AuthFilesScreen extends StatefulWidget {
  const AuthFilesScreen({
    Key key,
  }) : super(key: key);

  @override
  State<AuthFilesScreen> createState() => _AuthFilesScreenState();
}

class _AuthFilesScreenState extends State<AuthFilesScreen> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGlobalBlack,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kGlobalBlack,
        centerTitle: true,
        title: const CommonTextWidget(
          text: 'Документы',
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
                child: authController.authFiles == null ||
                        authController.authFiles.isEmpty
                    ? const Center(
                        child: Text('Нет файлов'),
                      )
                    : Column(
                        children: authController.authFiles
                            .map<Widget>(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaqFileWidget(
                                  type: e['type'],
                                  url: e['url'],
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
