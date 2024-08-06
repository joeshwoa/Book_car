import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/generated/assets.dart';

class SwitchToVanDialogCustom extends StatelessWidget {

  final bool optionally;
  final bool roundTrip;
  SwitchToVanDialogCustom({super.key, required this.optionally, this.roundTrip = false});

  late final BookTaxiCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
    }
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
          Image.asset(
            Assets.bookTaxiVan,
            width: Unit(context).iconSize(SizeData.s150),
            height: Unit(context).iconSize(SizeData.s150),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              optionally ? LocaleKeys.kSwitchToVanForAComfortableJourney.tr() : LocaleKeys.kSelectedCarSwitchedToVan.tr(),
              style: StyleData.textStyleGray600SB16,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              optionally ? LocaleKeys.kToEnsureAComfortableJourneyForAllPassengersWeRecommendSwitchingFromASedanToAVan.tr() : LocaleKeys.kWeChangedYourChoiceOfSedanToAVanBecauseYourNeedsExceededTheCapacityOfASedanCarWhichGuaranteesAComfortableJourney.tr(),
              style: StyleData.textStyleGray500R14,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(optionally)Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: SizeData.s8),
                child: MainButtonCustom(
                  onTap: () {
                    if (roundTrip) {
                      cubit.changeVehicleTypeRoundTrip(value: 'van');
                    } else {
                      cubit.changeVehicleType(value: 'van');
                    }

                    context.pop();
                  },
                  text: LocaleKeys.kSwitch.tr(),
                  textStyle: StyleData.textStylePrimary50M16,
                  color: ColorData.primaryColor1000,
                  height: SizeData.s48,
                ),
              ),
            ),
            if(optionally)Expanded(
              child: MainButtonCustom(
                onTap: () {
                  context.pop();
                },
                text: LocaleKeys.kClose.tr(),
                textStyle: StyleData.textStylePrimary500M14,
                color: ColorData.primaryColor50,
                height: SizeData.s48,
              ),
            ),
            if(!optionally)Expanded(
              child: MainButtonCustom(
                onTap: () {
                  if (roundTrip) {
                    cubit.changeVehicleTypeRoundTrip(value: 'van');
                  } else {
                    cubit.changeVehicleType(value: 'van');
                  }
                  context.pop();
                },
                text: LocaleKeys.kDone.tr(),
                textStyle: StyleData.textStylePrimary500M14,
                color: ColorData.primaryColor50,
              ),
            )
          ],
        ),
      ],
    );
  }
}