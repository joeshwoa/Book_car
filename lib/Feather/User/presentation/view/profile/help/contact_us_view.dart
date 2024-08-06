import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/list_tile_help_custom.dart';
import 'package:public_app/generated/assets.dart';

class ContactUsView extends StatelessWidget {

  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          AppBarCustom(title: LocaleKeys.kContactUs.tr()),
          Container(
            margin : EdgeInsets.only(
                top: Unit(context).getHeightSize*0.15,
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
                  ListTileHelpCustom(
                    image: Assets.userSendMassage,
                    title: LocaleKeys.kSendMessage.tr(),
                    fct: (){
                      GoRouter.of(context).push(AppRouter.kSendMessageView);
                    },
                  ),

                  SizedBox(height: SizeData.s15,),

                  ListTileHelpCustom(
                    image: Assets.userTrem,
                    title: LocaleKeys.kReportIssue.tr(),
                    fct: (){
                      GoRouter.of(context).push(AppRouter.kSendReportIssueView);
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
