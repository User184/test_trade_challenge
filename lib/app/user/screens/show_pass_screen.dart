import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

class ShowPass extends StatelessWidget {
  final String imageUrl;
  const ShowPass({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color(0xff3C6FE4),
        centerTitle: true,
        title: const CommonTextWidget(
          text: 'Паспорт',
          size: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 60,
          ),
        ),
      ),
    );
  }
}
