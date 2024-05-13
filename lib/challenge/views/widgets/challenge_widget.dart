import 'package:flutter/material.dart';

class ChallengeWidget extends StatelessWidget {
  final int id;
  final String title;
  final String type;
  final String dateStart;
  final String dateEnd;
  final int sumCost;
  // final TestCover testCover;
  // final List<TestMaterials> testMaterials;
  final bool testPassed;
  final bool canPassed;
  final Function button;

  const ChallengeWidget(
      {Key key,
      this.id,
      this.title,
      this.type,
      this.dateStart,
      this.dateEnd,
      this.sumCost,
      // this.testCover,
      // this.testMaterials,
      this.testPassed,
      this.canPassed,
      this.button})
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
          children: [
            // Stack(
            //   children: [
            //     SizedBox(
            //       width: double.infinity,
            //       height: 200,
            //       child: CachedNetworkImage(
            //         imageUrl: testCover.url,
            //         fit: BoxFit.fitHeight,
            //         placeholder: (context, url) => const Center(
            //           child: SizedBox(
            //             width: 20,
            //             height: 20,
            //             child: Center(child: CircularProgressIndicator()),
            //           ),
            //         ),
            //         errorWidget: (context, url, error) =>
            //             const Icon(Icons.error),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 140,left: 10),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(left: 10),
            //             child: Text(
            //               '${dateStart.substring(0, 10).replaceAll('-', '.')} - ${dateEnd.substring(0, 10).replaceAll('-', '.')}',
            //               style: Theme.of(context).textTheme.button.copyWith(
            //                     fontWeight: FontWeight.normal,
            //                     fontSize: 12.sp,
            //                     color: const Color(0xffffffff),
            //                   ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 10),
            //             child: Text(
            //               title,
            //               style: Theme.of(context).textTheme.button.copyWith(
            //                     fontWeight: FontWeight.w700,
            //                     fontSize: 20.sp,
            //                     color: const Color(0xffffffff),
            //                   ),
            //               overflow: TextOverflow.ellipsis,
            //               maxLines: 2,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Align(
            //         alignment: Alignment.topRight,
            //         child: Container(
            //           width: testPassed == true ? 150 : 90,
            //           height: 30,
            //           decoration: BoxDecoration(
            //             color: testPassed == true
            //                 ? Colors.white
            //                 : type == 'test' ? const Color(0xff3C6FE4) : const Color(0xff1FCED7),
            //             borderRadius: BorderRadius.circular(45),
            //           ),
            //           child: Center(
            //             child: Text(
            //               testPassed == true ? type == 'test' ? 'Тест пройден' : 'Опрос пройден' : '+$sumCost',
            //               style: Theme.of(context).textTheme.bodyText1.copyWith(
            //                     fontWeight: FontWeight.w600,
            //                     fontSize: 12.sp,
            //                     color: testPassed == true
            //                         ? type == 'test' ? const Color(0xff3C6FE4) : const Color(0xff1FCED7)
            //                         : const Color(0xffffffff),
            //                   ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: 30, bottom: canPassed == false ? 10 :  10, right: 30, top: 10),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(
            //         testPassed == true
            //             ? Colors.grey[400]
            //             : type == 'test'
            //                 ? const Color(0xff3C6FE4)
            //                 : const Color(0xff1FCED7),
            //       ),
            //     ),
            //     onPressed:  () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NewTestScreen(
            //             testId: id,
            //             type: type,
            //             passed: testPassed,
            //           ),
            //         ),
            //       );
            //     },
            //     child: Text(
            //       canPassed == false ? 'Посмотреть' :
            //       testPassed == true
            //           ?  type == 'test' ? 'Тест пройден' : 'Опрос пройден'
            //           : type == 'test'
            //               ? 'Пройти тест'
            //               : 'Пройти опрос',
            //       style: Theme.of(context).textTheme.button.copyWith(
            //             fontWeight: FontWeight.w700,
            //             fontSize: 16.sp,
            //             color: const Color(0xffffffff),
            //           ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
