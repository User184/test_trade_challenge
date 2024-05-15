import 'package:flutter/material.dart';

import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/home/controllers/nachislenie_controller.dart';

@immutable
class ActDownloadCard extends StatelessWidget {
  final NachislenieController controller;
  final Size size;
  final String text;
  final void Function() onTap;
  const ActDownloadCard({
    Key key,
    this.controller,
    this.size,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF9F9F9),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff1D1D1D).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 15, top: size.height * 0.02, bottom: size.height * 0.02),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 0,
                      color: const Color(0xff0025C2).withOpacity(0.1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.attach_file,
                    color: kGlobal,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: CommonTextWidget(
                  text: text,
                  fontWeight: FontWeight.w400,
                  size: 16,
                  maxLines: 3,
                  fontFamily: 'Arial',
                  color: kGlobal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
