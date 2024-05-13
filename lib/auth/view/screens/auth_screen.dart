import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import '../../../app/theme.dart';
import '../widgets/promo_cod_widget.dart';
import '../widgets/sms_code_widget.dart';
import '../widgets/start_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int currentIndex;
  final maskFormatter1 = MaskTextInputFormatter(mask: '+7 (###) ###-##-##');


  PageController _pageController;

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  nextFunction([bool code]) {
    if(code == true){
      _pageController.jumpToPage(2);
    }
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WIDTH = MediaQuery.of(context).size.width;
    final bool isKeyboardVisible =
    KeyboardVisibilityProvider.isKeyboardVisible(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onVerticalDragDown,
          GestureType.onVerticalDragStart,
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kGlobalBlack,
          body: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 230,
                        child: Image.asset('assets/images/logoblack.png'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'ДОБРО ПОЖАЛОВАТЬ!',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 200),
                  padding:
                  EdgeInsets.only(top: !isKeyboardVisible ? 200 : 50),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: onChangedFunction,
                      controller: _pageController,
                      children: <Widget>[
                        StartWidget(
                          next: nextFunction,
                        ),
                        PromoCodeWidget(
                          next: nextFunction,
                        ),
                        SmsCodeWidget(
                          next: nextFunction,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff6490F7).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
