
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';

class ConstantData{

  static String kDefaultLung='en';
  static String kLung='kLung';
  static String kToken='kToken';
  static String kRefresh='kRefresh';
  static String kLogin='kLogin';
  static String kShowOnBoarding='kShowOnBoarding';
  static String kRecentPlaces='kRecentPlaces';
  static String kEmail='kEmail';

  static String phoneNumberKiro = "+33 6 44 9 1 53 10";
  static String callUsKiro = "+33 6 44 9 1 53 10";
  static String mailKiro = "contact@kirolimo.fr";


  static BoxDecoration decorationIntro=BoxDecoration(
    gradient: LinearGradient(
      colors: [
        ColorData.gradientColor1,
        ColorData.gradientColor2,
        ColorData.gradientColor3,
        ColorData.gradientColor4,
        ColorData.gradientColor5,
        ColorData.gradientColor6,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static BoxDecoration decorationUser=BoxDecoration(
      borderRadius: BorderRadius.circular(SizeData.s16),
      color: ColorData.whiteColor200,
      boxShadow: [
        BoxShadow(
          color: ColorData.shadowColor1,
          offset: const Offset(0, 4),
          blurRadius: 8,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: ColorData.shadowColor2,
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ]
  );
}


enum TaxiType {
  sedan,
  van
}

enum Status {
  confirmed,
  cancelled,
  cancelledByClient,
  uncompleted,
  waitingConfirmation,
  newOffer
}

enum Payment {
  cash,
  cardOnBoard,
  cardOnLine
}

enum TimeState {
  past,
  upcoming
}

enum AddressType {
  pickUp,
  dropOff
}

enum MessageType {
  user,
  system
}