import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class ModificationRequestSentSuccessDialogCustom extends StatelessWidget {

  const ModificationRequestSentSuccessDialogCustom({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      content: SizedBox(
        width: Unit(context).getWidthSize*0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottieForgetMailSentDone,
              width: SizeData.s150,
              height: SizeData.s150,
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                'Your Modification request has been received',
                style: StyleData.textStyleGray500M14,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kPleaseCheckYourEmail.tr(),
                style: StyleData.textStyleGray500R12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      actions: [
        MainButtonCustom(
          onTap: () {
            context.go(AppRouter.kLayoutView, extra: true);
          },
          text: LocaleKeys.kHome.tr(),
          textStyle: StyleData.textStylePrimary500M14,
          color: ColorData.primaryColor50,
        ),
      ],
    );
  }
}