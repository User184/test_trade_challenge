import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/models/wlk_screen_model.dart';
import 'package:teklub/auth/onboarding_screen/widgets/indicator_widget.dart';
import 'package:teklub/auth/onboarding_screen/widgets/screen_widget.dart';

import '../../../app/theme.dart';
import '/app/routes/route.dart' as route;

class OnBoardingScreen extends StatefulWidget {
  final WlkScreen welcomeScreenModel;
  final bool isStart;
  final Function() onTap;

  const OnBoardingScreen({Key key, this.welcomeScreenModel, this.isStart, this.onTap}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;
  int currentIndex = 0;

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  bool lastScreen = false;

  List<Padding> getIndicator(int data) {
    lastScreen = false;
    List<Padding> list = [];
    for (var i = 0; i < data; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Indicator(
            positionIndex: i,
            currentIndex: currentIndex,
          ),
        ),
      );
      if (i == widget.welcomeScreenModel.data.length - 1) {
        lastScreen = true;
      }
    }
    return list;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WIDTH = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kGlobalBlack,
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset('assets/images/smoke.png'),
            widget.welcomeScreenModel == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CommonTextWidget(
                          text: 'Ошибка',
                          size: 18,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, route.startScreen);
                          },
                          child: const CommonTextWidget(
                            text: 'Обновить',
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                : PageView(
                    onPageChanged: onChangedFunction,
                    controller: _pageController,
                    children: widget.welcomeScreenModel.data
                        ?.map(
                          (e) => ScreenWidget(
                            url: e.url,
                            title: e.title,
                            text: e.text,
                            last: lastScreen,
                            onTap: widget.onTap,
                            // last: ,
                          ),
                        )
                        ?.toList(),
                  ),
            if (widget.welcomeScreenModel != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        getIndicator(widget.welcomeScreenModel.data.length),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
