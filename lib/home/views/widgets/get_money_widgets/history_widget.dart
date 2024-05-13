import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/home/views/screens/money/payment_info_screen.dart';

import '../../../../app/user/models/pass_model.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../../tests/models/test_model.dart';
import '../../screens/money/act_issuing_prize.dart';

class HistoryWidget extends StatefulWidget {
  final String status;
  final String actStatus;
  final String title;
  final String date;
  final String sum;
  final String id;
  final String type;
  final bool hasActs;
  final Function updt;
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;

  const HistoryWidget(
      {Key key,
      this.status,
      this.title,
      this.date,
      this.sum,
      this.id,
      this.type,
      this.hasActs,
      this.updt,
      this.model,
      this.passModel,
      this.promoModel,
      this.testModel,
      this.actStatus})
      : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    print('HasActs - ${widget.hasActs}, ActStatus - ${widget.actStatus}, Status - ${widget.status}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            if (widget.type == 'challenge') {
              if (widget.hasActs == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentInfoScreen(
                      title: widget.title,
                      id: widget.id,
                    ),
                  ),
                );
              } else {
                showModalBottomSheet(
                  barrierColor: Colors.black,
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  builder: (context) {
                    return ActIssuingPrize(
                      withdrawalId: widget.id,
                      model: widget.model,
                      testModel: widget.testModel,
                      passModel: widget.passModel,
                      promoModel: widget.promoModel,
                    );
                  },
                );
              }
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentInfoScreen(
                    title: widget.title,
                    id: widget.id,
                  ),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStatusIcon(),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CommonTextWidget(
                        text: _buildTitleString(),
                        size: 16,
                        color: const Color(0xff49536D),
                        fontWeight:
                            widget.hasActs ? FontWeight.w400 : FontWeight.w600,
                        fontFamily: 'Arial',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                CommonTextWidget(
                  text: widget.sum.replaceAll('-', '+'),
                  size: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arial',
                  color: const Color(0xff49536D),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8793B4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    var status = _getStatus();
    return Container(
      decoration: BoxDecoration(
        color: status == 'success' || status == 'accepted'
            ? const Color(0xff13971E)
            : status == 'rejected'
            ? const Color(0xffB51919)
            : Color(0xffF3F7FF),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: status == 'success' || status == 'accepted'
              ? const Icon(
            Icons.check,
            color: Color(0xff13971E),
            size: 20,
          )
              : status == 'rejected'
              ? const Icon(
            Icons.close,
            color: Color(0xffB51919),
            size: 20,
          )
              : const Icon(
            Icons.access_time,
            color: Color(0xff8793B4),
            size: 20,
          ),
        ),
      ),
    );
  }

  String _buildTitleString() {
    if (widget.hasActs) {
      if (widget.actStatus == 'success' || widget.actStatus == 'accepted') {
        return widget.status == 'in_process' ? "На проверке" : widget.title;
      } else {
        return widget.actStatus == 'rejected'
            ? widget.title : "Акт на проверке";
      }
    } else {
      return 'ЗАГРУЗИТЕ АКТ';
    }
  }

  String _getStatus() {
    if (widget.hasActs) {
      if (widget.actStatus == 'success' || widget.actStatus == 'accepted') {
        return widget.status;
      } else {
        return widget.actStatus;
      }
    } else {
      return 'rejected';
    }
  }

}