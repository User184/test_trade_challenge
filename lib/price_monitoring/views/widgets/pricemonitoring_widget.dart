import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class PriceMonitoringWidget extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final Function button;
  final int count;

  const PriceMonitoringWidget({
    Key key,
    this.image,
    this.title,
    this.button,
    this.date,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
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
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          date,
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                                color: const Color(0xffffffff),
                              ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.only(left: 10),
                        child: Text(
                          title,
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
                      width: 65,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xff3C6FE4),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Center(
                        child: Text(
                          '+$count',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: const Color(0xffffffff),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                   const Color(0xff3C6FE4),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Участвовать',
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
