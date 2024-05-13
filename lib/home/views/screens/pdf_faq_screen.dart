import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:teklub/app/common/components/url_laoucher.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewer extends StatefulWidget {
  final String url;

  const PdfViewer({Key key, this.url}) : super(key: key);

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonTextWidget(
          text: 'Просмотр',
          size: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xff49536D),
        ),
      ),
      body: Center(
        child: SfPdfViewer.network(
          widget.url,
          enableDocumentLinkAnnotation: false,
        ),
      ),
    );
  }
}
