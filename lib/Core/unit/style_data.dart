import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/font_weiget_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/unit.dart';


abstract class StyleData {

  static const fontFamily='Poppins';

  static Unit? unit;
  static init(BuildContext context) {
    unit = Unit(context);
  }

  static TextStyle textStyle12 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: 12,
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle12Regular = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: 12,
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle14 = TextStyle(
    color: ColorData.whiteColor200,
    fontWeight: FontWeightStyles.medium,
    fontSize: 14,
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle14Regular = TextStyle(
    color: ColorData.primaryColor100,
    fontWeight: FontWeightStyles.regular,
    fontSize: 14,
    height: 0.0,
    fontFamily: fontFamily,
  );

  // todo: text style
  // textStyle Color Weight Size
  static TextStyle textStylePrimary50R45 = TextStyle(
    color: ColorData.primaryColor50,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s45),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary50M16 = TextStyle(
    color: ColorData.primaryColor50,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary50SB16 = TextStyle(
    color: ColorData.primaryColor50,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary100R14 = TextStyle(
    color: ColorData.primaryColor100,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary200R14 = TextStyle(
    color: ColorData.primaryColor200,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary400R12 = TextStyle(
    color: ColorData.primaryColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary500R14 = TextStyle(
    color: ColorData.primaryColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary500M14 = TextStyle(
    color: ColorData.primaryColor500,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary500SB16 = TextStyle(
    color: ColorData.primaryColor500,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary500SB20 = TextStyle(
    color: ColorData.primaryColor500,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s20),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary500B16 = TextStyle(
    color: ColorData.primaryColor500,
    fontWeight: FontWeightStyles.bold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary600R12 = TextStyle(
    color: ColorData.primaryColor600,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary600M14 = TextStyle(
    color: ColorData.primaryColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary700M16 = TextStyle(
    color: ColorData.primaryColor700,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary800R12 = TextStyle(
    color: ColorData.primaryColor800,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStylePrimary800M16 = TextStyle(
    color: ColorData.primaryColor800,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStylePrimary1000M16 = TextStyle(
    color: ColorData.primaryColor1000,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray50M14 = TextStyle(
    color: ColorData.grayColor50,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray100M14 = TextStyle(
    color: ColorData.grayColor100,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray200R45 = TextStyle(
    color: ColorData.grayColor200,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s45),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray300R12 = TextStyle(
    color: ColorData.grayColor300,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray300R14 = TextStyle(
    color: ColorData.grayColor300,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray300M14 = TextStyle(
    color: ColorData.grayColor300,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray400R12 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray400R14 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray400R16 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray400M12 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray400M16 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray400SB14 = TextStyle(
    color: ColorData.grayColor400,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray500R12 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500R14 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500R24 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s24),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500M12 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500M14 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500M16 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500SB16 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray500SB20 = TextStyle(
    color: ColorData.grayColor500,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s20),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray600R12 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600R14 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600R16 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600M12 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600M14 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600M16 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600M18 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s18),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600SB14 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600SB16 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray600B12 = TextStyle(
    color: ColorData.grayColor600,
    fontWeight: FontWeightStyles.bold,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleGray700R14 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray700R16 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray700M12 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray700M14 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray700SB14 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleGray700SB16 = TextStyle(
    color: ColorData.grayColor700,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleWarning400R12 = TextStyle(
    color: ColorData.warningColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleWarning700R12 = TextStyle(
    color: ColorData.warningColor700,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleWarning800M16 = TextStyle(
    color: ColorData.warningColor800,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleDanger50M14 = TextStyle(
    color: ColorData.dangerColor50,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleDanger300R12 = TextStyle(
    color: ColorData.dangerColor300,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleDanger400R12 = TextStyle(
    color: ColorData.dangerColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleDanger400M12 = TextStyle(
    color: ColorData.dangerColor400,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleDanger500R14 = TextStyle(
    color: ColorData.dangerColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleDanger500M14 = TextStyle(
    color: ColorData.dangerColor500,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleDanger700R12 = TextStyle(
    color: ColorData.dangerColor700,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleWhite200R12 = TextStyle(
    color: ColorData.whiteColor200,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhite200R16 = TextStyle(
    color: ColorData.whiteColor200,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhite200M14 = TextStyle(
    color: ColorData.whiteColor200,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleNatural0M18 = TextStyle(
    color: ColorData.naturalColor0,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s18),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleNatural100R12 = TextStyle(
    color: ColorData.naturalColor100,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleBlue50M14 = TextStyle(
    color: ColorData.blueColor50,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleBlue400R12 = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue400R14 = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue400R16 = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue400M12 = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue400M14 = TextStyle(
    color: ColorData.blueColor400,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue500R12 = TextStyle(
    color: ColorData.blueColor500,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlue700M12 = TextStyle(
    color: ColorData.blueColor700,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleCustom2R12 = TextStyle(
    color: ColorData.customColor2,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom5R14 = TextStyle(
    color: ColorData.customColor5,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom7M14 = TextStyle(
    color: ColorData.customColor7,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom7B16 = TextStyle(
    color: ColorData.customColor7,
    fontWeight: FontWeightStyles.bold,
    fontSize: unit!.fontSize(SizeData.s16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom8M14 = TextStyle(
    color: ColorData.customColor8,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom9R12 = TextStyle(
    color: ColorData.customColor9,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom12R12 = TextStyle(
    color: ColorData.customColor12,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom13R12 = TextStyle(
    color: ColorData.customColor13,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleCustom13M14 = TextStyle(
    color: ColorData.customColor13,
    fontWeight: FontWeightStyles.medium,
    fontSize: unit!.fontSize(SizeData.s14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleSuccess700R12 = TextStyle(
    color: ColorData.successColor700,
    fontWeight: FontWeightStyles.regular,
    fontSize: unit!.fontSize(SizeData.s12),
    height: 0.0,
    fontFamily: fontFamily,
  );
}
