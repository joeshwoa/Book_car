import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/buttons/out_line_button_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/sign_up_dialog_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/log_in_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class ProfileAuthCustom extends StatelessWidget {
  const ProfileAuthCustom({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
      return Container(
        padding: EdgeInsets.all(SizeData.s15),
        decoration: BoxDecoration(
          color: ColorData.primaryColor25,
          borderRadius: BorderRadius.circular(SizeData.s16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Unit(context).getWidthSize*0.128,
                  width: Unit(context).getWidthSize*0.128,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.5,
                        color: ColorData.primaryColor600,
                      )
                  ),
                  child: ClipOval(
                    child: cubit.isUserLogin ?
                    CachedNetworkImage(imageUrl: cubit.userModel?.dataUserModel?.image??'', errorWidget: (context, url, error) => Image.asset(Assets.userProfileImageTest),fit: BoxFit.cover,)
                        : Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                      Assets.userUnLoginUserIcon,
                      color: ColorData.primaryColor600,
                    ),
                        ),
                  ),
                ),
                SizedBox(width: SizeData.s12,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.isUserLogin ? cubit.userModel?.dataUserModel?.name??'' : LocaleKeys.kHelloSignIn.tr(),
                        style: StyleData.textStyleGray600M12.copyWith(
                            fontSize: Unit(context).getWidthSize*0.032
                        ),
                      ),
                      SizedBox(height: SizeData.s5,),
                      Text(
                        cubit.isUserLogin ? cubit.userModel?.dataUserModel?.email??'': '${LocaleKeys.kExample.tr()}@gmail.com',
                        style: StyleData.textStyleGray400R14.copyWith(
                          color: ColorData.grayColor400,
                          fontSize: Unit(context).getWidthSize*0.032
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

            cubit.isUserLogin?Container():Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: SizeData.s15,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MainButtonCustom(
                          color: ColorData.primaryColor400,
                          onTap: () {
                            showDialog(context: context, barrierDismissible: false ,builder: (context) => const SignUpDialogCustom());
                          },
                          text: LocaleKeys.kSignUp.tr(),
                          textStyle: StyleData.textStyleWhite200M14,
                        ),
                      ),
                      SizedBox(width: SizeData.s10,),
                      Expanded(
                        child: OutLineButtonCustom(
                          onTap: () {
                            showDialog(context: context, barrierDismissible: false ,builder: (context) => const LogInDialogCustom());
                          },
                          text: LocaleKeys.kSignIn.tr(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
