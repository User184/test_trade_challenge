import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../controllers/referral_controller.dart';

class CopyWidget extends StatefulWidget {
  const CopyWidget({Key key, this.referralCode, this.controller})
      : super(key: key);

  final String referralCode;
  final ReferralController controller;

  @override
  State<CopyWidget> createState() => _CopyWidgetState();
}

class _CopyWidgetState extends State<CopyWidget> {
  bool isCopied = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCopied = true;
        });
        Clipboard.setData(ClipboardData(text: widget.referralCode ?? ""));
        widget.controller.showDialogCopy(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonTextWidget(
            text: widget.referralCode ?? "",
            fontWeight: FontWeight.w700,
            size: 26,
            color: const Color(0xff3C6FE4),
          ),
          const SizedBox(
            width: 15,
          ),
          SvgPicture.asset(
            !isCopied ? 'assets/images/copy.svg' : 'assets/images/copied.svg',
            color: kGlobal,
          ),
        ],
      ),
    );
  }
}
