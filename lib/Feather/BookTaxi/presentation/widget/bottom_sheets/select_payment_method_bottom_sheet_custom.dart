import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/generated/assets.dart';

class SelectPaymentMethodBottomSheetCustom extends StatelessWidget {

  SelectPaymentMethodBottomSheetCustom({super.key});

  late final BookTaxiCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
    }
    return BlocBuilder<BookTaxiCubit, BookTaxiState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: ColorData.whiteColor200,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeData.s16),
                topLeft: Radius.circular(SizeData.s16)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: EdgeInsets.all(SizeData.s12),
            decoration: BoxDecoration(
              color: ColorData.whiteColor200,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(SizeData.s16),
                  topLeft: Radius.circular(SizeData.s16)),
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        Text(
                          LocaleKeys.kPaymentMethod.tr(),
                          style: StyleData.textStyleGray700M14,
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  size: SizeData.s24,
                                  color: ColorData.grayColor600,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: SizeData.s4),
                    child: Center(
                      child: Text(
                        LocaleKeys.kHowDoYouPreferToPayQ.tr(),
                        style: StyleData.textStyleGray600R14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                    child: GestureDetector(
                      onTap: () {
                        cubit.changePayment(value: 'cash');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: SvgPicture.asset(
                              Assets.bookTaxiCashIcon,
                              width: Unit(context).iconSize(SizeData.s24),
                              height: Unit(context).iconSize(SizeData.s24),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(
                            LocaleKeys.kCash.tr(),
                            style: StyleData.textStyleGray600R14,
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            width: Unit(context).width(SizeData.s16),
                            height: Unit(context).width(SizeData.s16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: cubit.payment == 'cash'
                                      ? Unit(context).width(SizeData.s4)
                                      : Unit(context).width(SizeData.s1),
                                  color: cubit.payment == 'cash'
                                      ? ColorData.blueColor400
                                      : ColorData.grayColor300,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                    child: GestureDetector(
                      onTap: () {
                        cubit.changePayment(value: 'card_onboard');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: SvgPicture.asset(
                              Assets.bookTaxiCardIcon,
                              width: Unit(context).iconSize(SizeData.s24),
                              height: Unit(context).iconSize(SizeData.s24),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(
                            LocaleKeys.kCreditCardOnBoard.tr(),
                            style: StyleData.textStyleGray600R14,
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            width: Unit(context).width(SizeData.s16),
                            height: Unit(context).width(SizeData.s16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: cubit.payment == 'card_onboard'
                                      ? Unit(context).width(SizeData.s4)
                                      : Unit(context).width(SizeData.s1),
                                  color: cubit.payment == 'card_onboard'
                                      ? ColorData.blueColor400
                                      : ColorData.grayColor300,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  if(cubit.isSchedule())Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                    child: GestureDetector(
                      onTap: () {
                        cubit.changePayment(value: 'card_online');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: SvgPicture.asset(
                              Assets.bookTaxiCardIcon,
                              width: Unit(context).iconSize(SizeData.s24),
                              height: Unit(context).iconSize(SizeData.s24),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(
                            LocaleKeys.kCreditCardOnline.tr(),
                            style: StyleData.textStyleGray600R14,
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            width: Unit(context).width(SizeData.s16),
                            height: Unit(context).width(SizeData.s16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: cubit.payment == 'card_online'
                                      ? Unit(context).width(SizeData.s4)
                                      : Unit(context).width(SizeData.s1),
                                  color: cubit.payment == 'card_online'
                                      ? ColorData.blueColor400
                                      : ColorData.grayColor300,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: MainButtonCustom(
                      onTap: () {
                        if(cubit.pricingMethod == 'fixed') {

                          context.push(AppRouter
                              .kBookingSummaryView, extra: cubit);

                        } else {
                          context.pop(true);
                        }
                      },
                      text: LocaleKeys.kSubmit.tr(),
                      textStyle: StyleData.textStylePrimary50M16,
                      color: ColorData.primaryColor1000,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
