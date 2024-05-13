import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teklub/challenge/views/screens/promo_detail_screen.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../models/promo_model.dart';
import '../widgets/chart_widget.dart';

class ChallengeScreen extends StatelessWidget {
  final PromoModel promoDetail;
  final bool fromMainScreen;

  const ChallengeScreen(
      {Key key, this.promoDetail, this.fromMainScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fromMainScreen == true
        ? Scaffold(
            backgroundColor: Colors.white.withOpacity(1),
            body: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          promoDetail.data.cover.first.url,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CommonTextWidget(
                                          text: promoDetail.data.name,
                                          size: 20,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff49536D),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            CommonTextWidget(
                                              text: promoDetail.data.startDate
                                                  .substring(0, 10)
                                                  .replaceAll('-', '.'),
                                              size: 14,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xff49536D),
                                            ),
                                            const CommonTextWidget(
                                              text: ' - ',
                                              size: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff49536D),
                                            ),
                                            CommonTextWidget(
                                              text: promoDetail.data.endDate
                                                  .substring(0, 10)
                                                  .replaceAll('-', '.'),
                                              size: 14,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xff49536D),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CommonTextWidget(
                                          text: promoDetail.data.description,
                                          size: 17,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff49536D),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                  Column(
                                    children: promoDetail.data.results
                                        .map<Widget>(
                                          (e) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Center(
                                              child: ChartWidget(
                                                points: e.points,
                                                type: e.type,
                                                counts: e.result,
                                                width: 170,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.arrow_back_ios),
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
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: PromoDetailScreen(
              promoModel: promoDetail,
            ),
          );
  }
}
