import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/views/screens/nachislen/check_info_screen.dart';

class NachislenieWidget extends StatelessWidget {
  final String status;
  final String title;
  final String title2;
  final String date;
  final String sum;
  final String id;
  final String causer;
  final String type;

  const NachislenieWidget(
      {Key key,
      this.status,
      this.title,
      this.date,
      this.sum,
      this.id,
      this.causer,
      this.type,
      this.title2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(status);
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, bottom: 5),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckInfoScreen(
                  status: status,
                  title: title2,
                  comment: title,
                  createdAt: date,
                  amount: sum,
                ),
              ),
            );
            // if (causer == 'user-checks') {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CheckInfoScreen(
            //         id: id,
            //       ),
            //     ),
            //   );
            // }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // NachislenieStatusApply(
                //   status: status,
                // ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CommonTextWidget(
                        text: causer == 'challenges'
                            ? title2
                            : causer == 'tests'
                                ? title2
                                : '$title2 $id',
                        size: 16,
                        color: const Color(0xff49536D),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonTextWidget(
                      text: date,
                      size: 14,
                      color: const Color(0xff8793B4),
                      fontFamily: 'Arial',
                    )
                  ],
                ),
                const Spacer(),
                CommonTextWidget(
                  text: sum.toString() == '0' ? '' : sum.toString(),
                  size: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Arial',
                  color: const Color(0xff49536D),
                ),
                const Spacer(),
                // if (causer != 'tests')
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8793B4),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NachislenieStatusApply extends StatelessWidget {
  final String status;

  const NachislenieStatusApply({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status == 'success'
            ? const Color(0xff1FCED7)
            : status == 'failure'
                ? const Color(0xffFF6E7A)
                : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: status == 'success'
              ? const Icon(
                  Icons.check,
                  color: Color(0xff1FCED7),
                  size: 20,
                )
              : status == 'failure'
                  ? const Icon(
                      Icons.close,
                      color: Color(0xffFF6E7A),
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
}
