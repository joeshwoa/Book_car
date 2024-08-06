import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/generated/assets.dart';

class RequestAlreadyExistView extends StatelessWidget {

  final String id;
  RequestAlreadyExistView({super.key, this.id = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kRequestCancelled.tr(), iconOneType: IconOneType.back, iconTwoType: IconTwoType.empty,),
          Container(
            margin: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            decoration: BoxDecoration(
              color: ColorData.whiteColor200,
              borderRadius: BorderRadius.circular(SizeData.s16),
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(SizeData.s16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.bookTaxiBookAlreadyExist
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Text(
                              LocaleKeys.kThisRequestAlreadyExist.tr(),
                            style: StyleData.textStyleGray600SB16,
                          ),
                        ),
                        Text(
                          LocaleKeys.kYouRaisedASimilarRequestWithBookingID.tr()+id,
                          style: StyleData.textStyleGray600SB16,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      context.go(AppRouter.kLayoutView, extra: true);
                      UserCubit.get(context).changeCurrentIndexLayout(2);
                      BookTaxiCubit.get(context).reset();
                    },
                    text: LocaleKeys.kGoToMyBookings.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      context.go(AppRouter.kLayoutView, extra: true);
                      UserCubit.get(context).changeCurrentIndexLayout(0);
                      BookTaxiCubit.get(context).reset();
                    },
                    text: LocaleKeys.kHome.tr(),
                    textStyle: StyleData.textStylePrimary500M14,
                    color: ColorData.primaryColor50,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
