import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:sizer/sizer.dart';

import '../screens/challenge_screen.dart';

class PromoWidget extends StatelessWidget {
  final PromoModel promoDetail;

  const PromoWidget({
    Key key,
    this.promoDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: promoDetail.data.cover.isEmpty
                          ? ''
                          : promoDetail.data.cover.first.url,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '${promoDetail.data.startDate.substring(0, 10).replaceAll('-', '.')} - ${promoDetail.data.endDate.substring(0, 10).replaceAll('-', '.')}',
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                                color: const Color(0xffffffff),
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          promoDetail.data.name,
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                color: const Color(0xffffffff),
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xff3C6FE4),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Center(
                        child: Text(
                          promoDetail.data.results.isEmpty
                              ? '-'
                              : '+${promoDetail.data.results.first.points}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, right: 30, top: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff3C6FE4)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChallengeScreen(
                        promoDetail: promoDetail,
                        fromMainScreen: true,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Посмотреть',
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: const Color(0xffffffff),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
