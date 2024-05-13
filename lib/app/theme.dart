import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThemeSettings {
  TextStyle buttonTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: Colors.white,
    fontFamily: 'Arial',
  );

  static Color primaryColorText = const Color(0xff49536D);

  final headline6TextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
    color: const Color(0xff36313C),
    fontFamily: 'Arial',
  );

  final hintTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.sp,
    color: const Color(0xff777777),
    fontFamily: 'Arial',
  );

  final bodyTextStyle1 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: const Color(0xffffffff),
    fontFamily: 'Arial'
  );

  final bodyTextStyle2 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: const Color(0xff36313C),
    fontFamily: 'Arial',
  );

  ThemeData setTheme() {
    return ThemeData(
      textTheme: TextTheme(
        headline6: headline6TextStyle,
        bodyText1: bodyTextStyle1,
        bodyText2: bodyTextStyle2,
        headline1: hintTextStyle,
        button: buttonTextStyle,
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xffF3F7FF),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff49536D),
        ),
      ),
      primaryColor: const Color(0xff000000),
      backgroundColor: const Color(0xffffffff),
      scaffoldBackgroundColor: kGlobalBlack,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: bodyTextStyle1.copyWith(
            color: const Color(0xff131313).withOpacity(0.3), fontSize: 14.sp),
        // floatingLabelBehavior:FloatingLabelBehavior.always,
        labelStyle: bodyTextStyle1.copyWith(
            color: const Color(0xff131313),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xff3C6FE4),
              width: 1,
            )),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        filled: true,
        fillColor: const Color(0xffffffff),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kGlobalBlack,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kGlobalBlack,
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff3C6FE4),
          minimumSize: const Size(double.infinity, 42),
          // side: BorderSide(color: Colors.red, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 42),
          side: const BorderSide(color: Color(0xffffffff), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
    );
  }
}

const kGlobal = Color(0xffED1D24);
const kTextColor = Color(0xff49536D);
const kGlobalBlack = Color(0xff131313);
