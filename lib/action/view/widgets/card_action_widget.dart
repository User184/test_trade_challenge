import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teklub/action/models/actions_model.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../screens/details_screen.dart';

class CardActionWidget extends StatelessWidget {
  CardActionWidget({Key key, this.data}) : super(key: key);
  DataActions data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .19,
                foregroundDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xff1D1D1D).withOpacity(.7),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  image: data.cover != null
                      ? DecorationImage(
                          image: NetworkImage(data.cover[0].url),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    left: MediaQuery.of(context).size.width * .6,
                    right: 15),
                child: Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff13971E)),
                  child: const Center(
                    child: CommonTextWidget(
                      text: 'Активная',
                      fontWeight: FontWeight.w400,
                      size: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CommonTextWidget(
                        text:
                            '${DateTime.parse(data.dateStart).day}.${DateTime.parse(data.dateStart).month}.${DateTime.parse(data.dateStart).year}-${DateTime.parse(data.dateEnd).day}.${DateTime.parse(data.dateEnd).month}.${DateTime.parse(data.dateEnd).year}',
                        fontWeight: FontWeight.w400,
                        size: 13,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 8),
                      child: CommonTextWidget(
                        text: data.title,
                        fontWeight: FontWeight.w400,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 20, left: 18, right: 18),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: kGlobal,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(data: data)));
                },
                child: const SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: CommonTextWidget(
                        text: 'Посмотреть',
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
