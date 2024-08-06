import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/list_tile_help_custom.dart';
import 'package:public_app/generated/assets.dart';

class HelpCenterView extends StatelessWidget {

  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          AppBarCustom(title: LocaleKeys.kHelpCenter.tr()),
          Container(
          margin : EdgeInsets.only(top: Unit(context).getHeightSize*0.15,
              left: SizeData.s15,
              right: SizeData.s15),
            decoration: BoxDecoration(
              color: ColorData.whiteColor200,
              borderRadius: BorderRadius.circular(SizeData.s16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(SizeData.s16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.kHelpCenter.tr(),
                      style: StyleData.textStyleGray600R14,
                    ),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Gravida senectus nam tincidunt nullam dignissim quisque dis at.',
                    style: StyleData.textStyleGray400R12,
                  ),
                  SizedBox(height: SizeData.s20,),

                  ListTileHelpCustom(
                   image: Assets.userContactUs,
                   title: LocaleKeys.kContactUs.tr(),
                   fct: (){
                     GoRouter.of(context).push(AppRouter.kContactUsView);
                   },
                  ),

                  SizedBox(height: SizeData.s15,),

                  ListTileHelpCustom(
                    image: Assets.userFaq,
                    title: LocaleKeys.kFAQ.tr(),
                    fct: (){
                      GoRouter.of(context).push(AppRouter.kFAQView);
                    },
                  ),

                  SizedBox(height: SizeData.s15,),

                  ListTileHelpCustom(
                    image: Assets.userPolicy,
                    title: LocaleKeys.kPrivacyPolicy.tr(),
                    fct: (){
                      context.push(AppRouter.kPrivacyPolicyView);
                    },
                  ),

                  SizedBox(height: SizeData.s15,),

                  ListTileHelpCustom(
                    image: Assets.userTrem,
                    title: LocaleKeys.kTermsAndConditions.tr(),
                    fct: (){
                      context.push(AppRouter.kTermsAndConditionsView);
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
