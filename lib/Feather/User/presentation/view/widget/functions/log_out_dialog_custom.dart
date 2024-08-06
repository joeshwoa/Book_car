import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/generated/assets.dart';

buildLogoutDialog({required BuildContext context,}){
  return AlertDialog(
    alignment: Alignment.center,
    backgroundColor: ColorData.whiteColor200,
    elevation: 0.0,
    contentPadding: EdgeInsets.all(SizeData.s20),
    insetPadding : EdgeInsets.all(SizeData.s20),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          Assets.lottieLogOutDialog,
          width: Unit(context).getWidthSize*0.4,
          height: Unit(context).getWidthSize*0.4,
          alignment: Alignment.center,
        ),

        Text(LocaleKeys.kAreYouSureYouWantLogout.tr(),
          textAlign: TextAlign.center,
          style: StyleData.textStyle14.copyWith(
            color: ColorData.grayColor500,
            fontSize: Unit(context).getWidthSize*0.037,
          ),
        ),

        SizedBox(height: SizeData.s20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: MainButtonCustom(onTap: (){
                Navigator.pop(context);
              }, text: LocaleKeys.kBack.tr(),
                textStyle: StyleData.textStyle14.copyWith(
                    color: ColorData.primaryColor500,
                    fontSize: Unit(context).getWidthSize*0.042
                ),
                color: ColorData.primaryColor50,
              ),
            ),

            SizedBox(width: SizeData.s10,),

            Expanded(
              flex: 2,
              child: MainButtonCustom(onTap: (){
                BlocProvider.of<UserCubit>(context).logout();
                Navigator.of(context).pop();
              }, text: LocaleKeys.kLogOut.tr(),
                color: ColorData.dangerColor1000,
                textStyle: StyleData.textStyle14.copyWith(
                    color: ColorData.grayColor100,
                    fontSize: Unit(context).getWidthSize*0.042
                ),
              ),
            ),
          ],
        ),

      ],
    ),
  );
}

