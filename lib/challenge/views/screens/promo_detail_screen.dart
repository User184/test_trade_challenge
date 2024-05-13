import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/challenge/views/widgets/chart_widget.dart';

import '../../../app/common/components/common_text_widget.dart';

class PromoDetailScreen extends StatelessWidget {
  final PromoModel promoModel;

  const PromoDetailScreen({
    Key key,
    this.promoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: promoModel.data.cover.first.url,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CommonTextWidget(
                  text: promoModel.data.name,
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
                      text: promoModel.data.startDate
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
                      text: promoModel.data.endDate
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
                  text: promoModel.data.description,
                  size: 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff49536D),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Column(
            children: promoModel.data.results
                .map<Widget>(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 20),
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
    );
  }
}
