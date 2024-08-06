
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

buildReportDialog({required BuildContext context, required String msg,required String title}){
  return AlertDialog(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SizeData.s16),
    ),
    insetPadding: EdgeInsets.all(SizeData.s20),
    contentPadding: EdgeInsets.all(SizeData.s20),
    alignment: Alignment.center,
    backgroundColor: ColorData.whiteColor200,
    title: Text(title,
      style: StyleData.textStyle14.copyWith(
          color: ColorData.grayColor500,
          fontSize:Unit(context).getWidthSize*0.042
      ),
      textAlign: TextAlign.center,
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          Assets.lottieReportMsg,
          width: Unit(context).getWidthSize*0.4,
          height: Unit(context).getWidthSize*0.4,
          alignment: Alignment.center,
        ),
        SizedBox(height: SizeData.s15,),
        Text(msg,
          style:StyleData.textStyle14.copyWith(
              color: ColorData.grayColor500,
              fontSize: Unit(context).getWidthSize*0.037
          ), textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeData.s20,),
        MainButtonCustom(onTap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, text: LocaleKeys.kDone.tr(),
          textStyle: StyleData.textStyle14.copyWith(
              color: ColorData.whiteColor200,
              fontSize: Unit(context).getWidthSize*0.042
          ),
          color: ColorData.primaryColor1000,
        )
      ],
    ),
  );
}

