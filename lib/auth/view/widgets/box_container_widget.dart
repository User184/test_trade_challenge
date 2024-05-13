import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/common/components/common_text_widget.dart';

class BoxContainerWidget extends StatelessWidget {
  const BoxContainerWidget({Key key, this.text, this.isSelect}) : super(key: key);

  final bool isSelect;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF3F7FF),
          borderRadius: BorderRadius.circular(15),
          border: isSelect? Border.all(
            color: Colors.blue,
            width: 1,
          ):null,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 2),
              color: const Color(0xff0025C2).withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelect ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.withOpacity(.3),
                    width: 1,
                  ),
                ),
                child: isSelect
                    ? Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                      )
                    : SizedBox(),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: size.width / 1.5,
                child: CommonTextWidget(
                  text: text,
                  fontWeight: FontWeight.w500,
                  size: 16,
                  color: Color(0xff49536D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
