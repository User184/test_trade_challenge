import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

class NewsWidget extends StatelessWidget {
  final String image;
  final int likes;
  final int watch;
  final String date;
  final String title;

  const NewsWidget(
      {Key key, this.image, this.likes, this.watch, this.date, this.title})
      : super(key: key);

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10, top: MediaQuery.of(context).size.width * 0.33),
                  child: CommonTextWidget(
                    text: title.toString(),
                    fontWeight: FontWeight.w700,
                    size: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CommonTextWidget(
                        text: likes.toString(),
                        size: 16,
                        color: const Color(0xff49536D),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CommonTextWidget(
                        text: watch.toString(),
                        size: 16,
                        color: const Color(0xff49536D),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CommonTextWidget(
                      text: date,
                      size: 16,
                      color: const Color(0xff8793B4),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
