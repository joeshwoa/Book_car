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

class RatingSubmittedDialogCustom extends StatelessWidget {
  const RatingSubmittedDialogCustom({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            Assets.lottieRatingSubmittedDialog,
            width: Unit(context).iconSize(SizeData.s150),
            height: Unit(context).iconSize(SizeData.s150),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              'Thank you for taking the time to share your Experience with Us',
              style: StyleData.textStyleGray500M14,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        MainButtonCustom(
          onTap: () {
            context.pop();
            context.go(AppRouter.kLayoutView, extra: true);
          },
          text: LocaleKeys.kHome.tr(),
          textStyle: StyleData.textStylePrimary500M14,
          color: ColorData.primaryColor50,
        )
      ],
    );
  }
}