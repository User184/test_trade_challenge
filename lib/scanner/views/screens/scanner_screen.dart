import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/scanner/data/api_service.dart';
import 'package:teklub/scanner/models/scan_models.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '/app/routes/route.dart' as route;

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String qr;
  bool camState = true;

  String scanResult = '';

  ScanRequestModel splitQrString(qr) {
    List res = qr.split('&');
    List<String> res2 = [];
    for (var element in res) {
      var r = element.toString().replaceAll(RegExp("n|=|t|s|i|f|p|'"), "");
      res2.add(r);
    }
    return ScanRequestModel(
      t: res2[0].length == 13 ? res2[0] + '00' : res2[0],
      s: res2[1],
      fn: res2[2],
      i: res2[3],
      fp: res2[4],
      n: res2[5],
    );
  }

  @override
  initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        qr = scanData.code;
        print(qr);
        if (qr != null) {
          setState(() {
            camState = false;
          });
          ScanRequestModel scanData = splitQrString(qr);
          qr = null;
          var res = await ApiScanService.scanChecks(scanData);
          if (res is SuccessRequestScan) {
            if (res.success == 'true') {
              setState(() {
                scanResult = 'true';
              });
            } else if (res.success == 'false') {
              setState(() {
                scanResult = 'false';
              });
            }
          }

          if (res is ErrorRequestScan) {
            setState(() {
              camState = false;
            });
            CustomSnackBar.badSnackBar(context, 'Ошибка. Попробуйте позже');
          }
        } else {
          setState(() {
            camState = false;
          });
          CustomSnackBar.badSnackBar(context, 'Ошибка. Попробуйте позже');
        }
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (controller != null) {
      debugPrint('reassemble : $controller');
      if (Platform.isAndroid) {
        await controller.pauseCamera();
      } else if (Platform.isIOS) {
        await controller.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
    camState = false;
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: camState
                      ? SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: QRView(
                            onQRViewCreated: _onQRViewCreated,
                            key: qrKey,
                          )
                          // QrCamera(
                          //   onError: (context, error) => Text(
                          //     error.toString(),
                          //     style: const TextStyle(color: Colors.red),
                          //   ),
                          //   qrCodeCallback: (code) async {
                          //     qr = code;
                          //
                          //     if (qr != null) {
                          //       setState(() {
                          //         camState = false;
                          //       });
                          //       ScanRequestModel scanData = splitQrString(qr);
                          //       qr = null;
                          //       var res =
                          //           await ApiScanService.scanChecks(scanData);
                          //       if (res is SuccessRequestScan) {
                          //         if (res.success == 'true') {
                          //           setState(() {
                          //             scanResult = 'true';
                          //           });
                          //         } else if (res.success == 'false') {
                          //           setState(() {
                          //             scanResult = 'false';
                          //           });
                          //         }
                          //       }
                          //
                          //       if (res is ErrorRequestScan) {
                          //         setState(() {
                          //           camState = false;
                          //         });
                          //         CustomSnackBar.badSnackBar(
                          //             context, 'Ошибка. Попробуйте позже');
                          //       }
                          //     } else {
                          //       setState(() {
                          //         camState = false;
                          //       });
                          //       CustomSnackBar.badSnackBar(
                          //           context, 'Ошибка. Попробуйте позже');
                          //     }
                          //   },
                          //   child: Center(
                          //     child: Container(
                          //       width: 220,
                          //       height: 220,
                          //       decoration: BoxDecoration(
                          //         color: Colors.transparent,
                          //         border: Border.all(
                          //             color: Colors.white,
                          //             width: 2.0,
                          //             style: BorderStyle.solid),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          )
                      : Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffF5F5F5), // border color
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  scanResult = '';
                                  camState = !camState;
                                });
                              },
                              icon: const Icon(
                                Icons.crop_free,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                ),
                // Text("QRCODE: $qr"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: scanResult == 'false'
                  ? const Color(0xffFF6E7A)
                  : scanResult == 'true'
                      ? const Color(0xff1FCED7)
                      : Colors.blue.withOpacity(0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Stack(
                children: [
                  SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FutureBuilder(
                        //     future: ApiScanService.getMechanic(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         return GestureDetector(
                        //           onTap: () {
                        //             setState(() {
                        //               camState = false;
                        //             });
                        //             if (snapshot.data is MechanicModel) {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => MechanicScreen(
                        //                     mechanicModel: snapshot.data,
                        //                   ),
                        //                 ),
                        //               );
                        //             }
                        //           },
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Container(
                        //               decoration: const BoxDecoration(
                        //                 color: Color(0xffF5F5F5),
                        //                 // border color
                        //                 shape: BoxShape.circle,
                        //               ),
                        //               child: const Padding(
                        //                   padding: EdgeInsets.all(5),
                        //                   child: Icon(Icons.info_outline)),
                        //             ),
                        //           ),
                        //         );
                        //       }
                        //       return GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             camState = false;
                        //           });
                        //           CustomSnackBar.badSnackBar(
                        //               context, 'Ошибка запроса');
                        //         },
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Container(
                        //             decoration: const BoxDecoration(
                        //               color: Color(0xffF5F5F5), // border color
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Padding(
                        //                 padding: EdgeInsets.all(5),
                        //                 child: Icon(Icons.info_outline)),
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        GestureDetector(
                          onTap: () {
                            camState = false;

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffF5F5F5), // border color
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.highlight_off)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        scanResult == 'false'
                            ? SvgPicture.asset(
                                'assets/images/bad.svg',
                                semanticsLabel: 'bad',
                                fit: BoxFit.fitWidth,
                              )
                            : scanResult == 'true'
                                ? SvgPicture.asset(
                                    'assets/images/good.svg',
                                    semanticsLabel: 'good',
                                    fit: BoxFit.fitWidth,
                                  )
                                : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        scanResult == 'false'
                            ? const CommonTextWidget(
                                text: 'Чек уже есть в базе',
                                size: 20,
                                textAlign: TextAlign.center,
                              )
                            : scanResult == 'true'
                                ? const CommonTextWidget(
                                    text: 'Спасибо!\nЧек отправлен на проверку',
                                    size: 20,
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (scanResult != 'true')
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
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
                    onTap: () {
                      setState(() {
                        camState = false;
                      });
                      Navigator.pushNamed(context, route.getHandCheckAddScreen);
                    },
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CommonTextWidget(
                              text: 'Внести вручную',
                              fontWeight: FontWeight.w700,
                              size: 16,
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
      // floatingActionButton: FloatingActionButton(
      //     child: Text(
      //       "press me",
      //       textAlign: TextAlign.center,
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         camState = !camState;
      //       });
      //     }),
    );
  }
}
