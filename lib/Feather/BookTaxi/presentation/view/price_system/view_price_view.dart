import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/bottom_sheets/select_payment_method_bottom_sheet_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/buttons/fixed_price_item_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class ViewPriceView extends StatelessWidget {

  final bool secondPriceInRoundTrip;
  ViewPriceView({super.key, required this.secondPriceInRoundTrip});

  late final BookTaxiCubit cubit;

  bool first = true;

  TextEditingController flexPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      cubit.updateStateLessPageVar(change: () {
        if(!secondPriceInRoundTrip) {
          if(cubit.roundTrip) {
            cubit.priceRoundTripLoaded = false;
            cubit.priceLoaded = false;
            cubit.getTaxiPrices();
            cubit.getTaxiPricesRoundTrip();
          } else {
            cubit.priceLoaded = false;
            cubit.getTaxiPrices();
          }
        }
      });
    }
    return BlocListener<BookTaxiCubit, BookTaxiState>(
  listener: (context, state) {
    if (state is SuccessBookPricesState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.priceLoaded = true;
      });
    }
    if (state is SuccessBookPricesRoundTripState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.priceRoundTripLoaded = true;
      });
    }
    if (state is SuccessBookTaxiState && cubit.pricingMethod == 'flexible') {
      cubit.updateStateLessPageVar(change: (){
        cubit.bookingRequestSanded = true;
      });
      context.push(AppRouter.kRequestSandedView, extra: {
        'showCancelButton': true,
      });
    }
    if (state is AlreadyExistsBookErrorState && cubit.pricingMethod == 'flexible') {
      context.push(AppRouter.kRequestAlreadyExistView, extra: {
        'id': state.id
      });
    }
  },
  child: BlocBuilder<BookTaxiCubit, BookTaxiState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorData.whiteColor200,
          body: Stack(
            children: [
              LayoutAppBarCustom(
                title: LocaleKeys.kFindDriver.tr(),
                iconOneType: IconOneType.logo,
                iconTwoType: IconTwoType.call,
              ),
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
                child: Padding(
                  padding: EdgeInsets.all(SizeData.s16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if ((!cubit.priceLoaded && !cubit.priceRoundTripLoaded && cubit.roundTrip) || (!cubit.priceLoaded && !cubit.roundTrip))
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if ((cubit.priceLoaded && cubit.priceRoundTripLoaded && cubit.roundTrip) || (cubit.priceLoaded && !cubit.roundTrip))Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kChoosePriceSystem
                                                .tr(),
                                            style:
                                                StyleData.textStyleGray600M14,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Text(
                                          LocaleKeys.kSelectWhatYouPrefer
                                              .tr(),
                                          style:
                                              StyleData.textStyleGray600R12,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if(cubit.isSchedule())Padding(
                                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      if (cubit.pricingMethod == 'flexible')
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorData.blueColor25,
                                            border: Border.all(
                                                color: ColorData.blueColor200,
                                                width: Unit(context)
                                                    .width(SizeData.s1)),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    SizeData.s16),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(SizeData.s8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: SizeData.s64),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      LocaleKeys
                                                          .kTotalFlexiblePrice
                                                          .tr(),
                                                      style: StyleData
                                                          .textStyleGray600M14,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    LocaleKeys
                                                        .kYouCanSelectYourSuitableCarAndPriceAndClickSendRequest
                                                        .tr(),
                                                    style: StyleData
                                                        .textStyleGray600R12,
                                                    textAlign:
                                                        TextAlign.start,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(vertical: SizeData.s8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${LocaleKeys.kMin.tr()}: ${(cubit.roundTrip?cubit.prices.first['price']+cubit.pricesRoundTrip.first['price']??0:cubit.prices.first['price']).toInt()-5}€',
                                                        style: StyleData
                                                            .textStyleGray700M12,
                                                      ),
                                                      SizedBox(
                                                        width: Unit(context)
                                                            .width(
                                                                SizeData.s8),
                                                      ),
                                                      Text(
                                                        '${LocaleKeys.kMax.tr()}: ${(cubit.roundTrip?cubit.prices.last['price']+cubit.pricesRoundTrip.last['price']??0:cubit.prices.last['price']).toInt()+10}€',
                                                        style: StyleData
                                                            .textStyleGray700M12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(vertical: SizeData.s8),
                                                  child: TextFormField(
                                                    controller:
                                                        flexPriceController,
                                                    decoration:
                                                        InputDecoration(
                                                      border: BorderData
                                                          .outlineInputBorderGray200W1R8,
                                                      enabledBorder: BorderData
                                                          .outlineInputBorderGray200W1R8,
                                                      focusedBorder: BorderData
                                                          .outlineInputBorderBlue300W1R8,
                                                      errorBorder: BorderData
                                                          .outlineInputBorderDanger400W1R8,
                                                      focusedErrorBorder:
                                                          BorderData
                                                              .outlineInputBorderDanger400W1R8,
                                                      hintText: '€00.00',
                                                      hintStyle: StyleData
                                                          .textStyleGray400R12,
                                                    ),
                                                    validator: (value) {
                                                      if ((value == null || value.isEmpty) && cubit.pricingMethod == 'flexible') {
                                                        return LocaleKeys.kPleaseFillThisField.tr();
                                                      }
                                                      if ((int.tryParse(value!)??0) >= (cubit.roundTrip?cubit.prices.first['price']+cubit.pricesRoundTrip.first['price']??0:cubit.prices.first['price']).toInt()-5 && (int.tryParse(value)??0) <= (cubit.roundTrip?cubit.prices.last['price']+cubit.pricesRoundTrip.last['price']??0:cubit.prices.last['price']).toInt()+10 && cubit.pricingMethod == 'flexible') {
                                                        return LocaleKeys.kPleasePriceInRange.tr();
                                                      }
                                                      return null;
                                                    },
                                                    autofocus: false,
                                                    autofillHints: const [],
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    obscureText: false,
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(
                                                            signed: false, decimal: false),
                                                  ),
                                                ),
                                                if (cubit.flexiblePriceError)
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(vertical: SizeData.s8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  SizeData
                                                                      .s4),
                                                          child: SvgPicture
                                                              .asset(
                                                            Assets
                                                                .bookTaxiWarningIcon,
                                                            width: Unit(
                                                                    context)
                                                                .iconSize(
                                                                    SizeData
                                                                        .s16),
                                                            height: Unit(
                                                                    context)
                                                                .iconSize(
                                                                    SizeData
                                                                        .s16),
                                                            color: ColorData
                                                                .dangerColor300,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            LocaleKeys
                                                                .kYourPriceMustBeGreaterThanMinPrice
                                                                .tr(),
                                                            style: StyleData
                                                                .textStyleDanger300R12,
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (cubit.flexiblePriceWarning)
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(vertical: SizeData.s8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  SizeData
                                                                      .s4),
                                                          child: SvgPicture
                                                              .asset(
                                                            Assets
                                                                .bookTaxiWarningIcon,
                                                            width: Unit(
                                                                    context)
                                                                .iconSize(
                                                                    SizeData
                                                                        .s16),
                                                            height: Unit(
                                                                    context)
                                                                .iconSize(
                                                                    SizeData
                                                                        .s16),
                                                            color: ColorData
                                                                .warningColor400,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            LocaleKeys
                                                                .kDriversCanAcceptOrIncreaseYourOfferPrice
                                                                .tr(),
                                                            style: StyleData
                                                                .textStyleWarning400R12,
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(vertical: SizeData.s8),
                                                  child: MainButtonCustom(
                                                    onTap: () async {
                                                      if((int.tryParse(flexPriceController.text)??0) >= (cubit.roundTrip?cubit.prices.first['price']+cubit.pricesRoundTrip.first['price']??0:cubit.prices.first['price']).toInt()-5 && (int.tryParse(flexPriceController.text)??0) <= (cubit.roundTrip?cubit.prices.last['price']+cubit.pricesRoundTrip.last['price']??0:cubit.prices.last['price']).toInt()+10 && cubit.pricingMethod == 'flexible') {
                                                        cubit.updateStateLessPageVar(change: () {
                                                          cubit.flexiblePriceError = false;
                                                          cubit.flexiblePriceWarning = false;
                                                        });
                                                        cubit.changePrice(
                                                            value: int.tryParse(
                                                                flexPriceController
                                                                    .text)!);

                                                        bool selected = await showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext context) => SelectPaymentMethodBottomSheetCustom(),
                                                        );
                                                        if (selected) {
                                                          cubit.updateStateLessPageVar(change: (){
                                                            cubit.bookingRequestSanded = false;
                                                          });

                                                          cubit.bookTaxiWithFlexiblePrice();
                                                        }
                                                      } else if ((int.tryParse(flexPriceController.text)??0) < (cubit.roundTrip?cubit.prices.first['price']+cubit.pricesRoundTrip.first['price']??0:cubit.prices.first['price']).toInt()-5) {
                                                        cubit.updateStateLessPageVar(change: () {
                                                          cubit.flexiblePriceError = true;
                                                          cubit.flexiblePriceWarning = false;
                                                        });
                                                      } else if ((int.tryParse(flexPriceController.text)??0) > (cubit.roundTrip?cubit.prices.last['price']+cubit.pricesRoundTrip.last['price']??0:cubit.prices.last['price']).toInt()+10) {
                                                        cubit.updateStateLessPageVar(change: () {
                                                          cubit.flexiblePriceError = false;
                                                          cubit.flexiblePriceWarning = true;
                                                        });
                                                      }
                                                    },
                                                    textStyle: StyleData
                                                        .textStyleBlue50M14,
                                                    text: LocaleKeys
                                                        .kSendOffer
                                                        .tr(),
                                                    color: ColorData
                                                        .blueColor400,
                                                    loading: !cubit.bookingRequestSanded,
                                                    loadingColor: ColorData.blueColor50,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!secondPriceInRoundTrip) {
                                            if(cubit.isSchedule()) {
                                              cubit.changePricingMethod(
                                                  value: 'flexible');
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorData.whiteColor200,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeData.s16),
                                              border: cubit.pricingMethod ==
                                                      'flexible'
                                                  ? Border.all(
                                                      color: ColorData
                                                          .blueColor300,
                                                      width: Unit(context)
                                                          .width(SizeData.s1))
                                                  : Border.all(
                                                      color: ColorData
                                                          .grayColor200,
                                                      width: Unit(context)
                                                          .width(
                                                              SizeData.s1))),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.symmetric(horizontal: SizeData.s8, vertical: SizeData.s16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.kFlexiblePrice
                                                      .tr(),
                                                  style: StyleData
                                                      .textStyleGray600R14,
                                                ),
                                                Container(
                                                  width: Unit(context)
                                                      .width(SizeData.s16),
                                                  height: Unit(context)
                                                      .width(SizeData.s16),
                                                  decoration: BoxDecoration(
                                                      shape:
                                                          BoxShape.circle,
                                                      border: Border.all(
                                                        width: cubit.pricingMethod ==
                                                                'flexible'
                                                            ? Unit(context)
                                                                .width(
                                                                    SizeData
                                                                        .s4)
                                                            : Unit(context)
                                                                .width(
                                                                    SizeData
                                                                        .s1),
                                                        color: cubit.pricingMethod ==
                                                                'flexible'
                                                            ? ColorData
                                                                .blueColor400
                                                            : ColorData
                                                                .grayColor300,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeData.s8),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      if (cubit.pricingMethod == 'fixed')
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorData.blueColor25,
                                            border: Border.all(
                                                color: ColorData.blueColor200,
                                                width: Unit(context)
                                                    .width(SizeData.s1)),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    SizeData.s16),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(SizeData.s8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: SizeData.s64, bottom: SizeData.s8),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      cubit.roundTrip && !secondPriceInRoundTrip ? LocaleKeys
                                                          .kTotalFixedPrice
                                                          .tr() : cubit.roundTrip && secondPriceInRoundTrip ? LocaleKeys.kTotalRoundTripFixedPrice.tr() : LocaleKeys
                                                          .kTotalFixedPrice
                                                          .tr(),
                                                      style: StyleData
                                                          .textStyleGray600M14,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    LocaleKeys
                                                        .kYouCanSelectYourSuitableCarAndPriceAndClickSendRequest
                                                        .tr(),
                                                    style: StyleData
                                                        .textStyleGray600R12,
                                                    textAlign:
                                                        TextAlign.start,
                                                  ),
                                                ),
                                                if(!secondPriceInRoundTrip)for (int i = 0;
                                                    i < cubit.prices.length;
                                                    i++) ...[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(vertical: SizeData.s8),
                                                    child:
                                                        FixedPriceItemButtonCustom(
                                                      onTap: () {
                                                        if(cubit.roundTrip) {
                                                          if (!secondPriceInRoundTrip) {
                                                            cubit.updateStateLessPageVar(change: () {
                                                              cubit.selectedPriceNumber = i;
                                                            },);
                                                            if(cubit.isSchedule()) {
                                                              cubit.changePricingMethod(
                                                                  value: 'fixed');
                                                            }
                                                            cubit.changePrice(
                                                                value: cubit
                                                                    .prices[i]
                                                                ['price'].toInt());
                                                            cubit.changeVehicleType(value: cubit.prices[i]['type']);
                                                            context.push(AppRouter.kViewPriceView, extra: {
                                                              'secondPriceInRoundTrip': true
                                                            });
                                                          } else {
                                                            cubit.updateStateLessPageVar(change: () {
                                                              cubit.selectedPriceNumberRoundTrip = i;
                                                            },);
                                                            if(cubit.isSchedule()) {
                                                              cubit.changePricingMethod(
                                                                  value: 'fixed');
                                                            }
                                                            cubit.changePriceRoundTrip(
                                                                value: cubit
                                                                    .pricesRoundTrip[i]
                                                                ['price'].toInt());
                                                            cubit.changeVehicleTypeRoundTrip(value: cubit.prices[i]['type']);
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (BuildContext context) => SelectPaymentMethodBottomSheetCustom(),
                                                            );
                                                          }
                                                        } else {
                                                          cubit.updateStateLessPageVar(change: () {
                                                            cubit.selectedPriceNumber = i;
                                                          },);
                                                          cubit.changePrice(
                                                              value: cubit
                                                                  .prices[i]
                                                              ['price'].toInt());
                                                          cubit.changeVehicleType(value: cubit.prices[i]['type']);
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (BuildContext context) => SelectPaymentMethodBottomSheetCustom(),
                                                          );
                                                        }

                                                      },
                                                      passengersNumber:
                                                          cubit.prices[i]
                                                              ['passengers'],
                                                      price: cubit.prices[i]
                                                          ['price'].toInt(),
                                                      taxiType: cubit.prices[
                                                                      i]
                                                                  ['type'] ==
                                                              'sedan'
                                                          ? TaxiType.sedan
                                                          : TaxiType.van,
                                                      selected: cubit.selectedPriceNumber == i,
                                                    ),
                                                  ),
                                                ],
                                                if(secondPriceInRoundTrip)for (int i = 0;
                                                i < cubit.pricesRoundTrip.length;
                                                i++) ...[
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: SizeData.s8),
                                                    child:
                                                    FixedPriceItemButtonCustom(
                                                      onTap: () {
                                                        if(cubit.roundTrip) {
                                                          if (!secondPriceInRoundTrip) {
                                                            cubit.updateStateLessPageVar(change: () {
                                                              cubit.selectedPriceNumber = i;
                                                            },);
                                                            if(cubit.isSchedule()) {
                                                              cubit.changePricingMethod(
                                                                  value: 'fixed');
                                                            }
                                                            cubit.changePrice(
                                                                value: cubit
                                                                    .prices[i]
                                                                ['price'].toInt());
                                                            cubit.changeVehicleType(value: cubit.prices[i]['type']);
                                                            context.push(AppRouter.kNoAvailabilityOutSideCountriesView, extra: {
                                                              'secondPriceInRoundTrip': true
                                                            });
                                                          } else {
                                                            if(cubit.isSchedule()) {
                                                              cubit.updateStateLessPageVar(change: () {
                                                                cubit.selectedPriceNumberRoundTrip = i;
                                                              },);
                                                              cubit.changePricingMethod(
                                                                  value: 'fixed');
                                                            }
                                                            cubit.changePriceRoundTrip(
                                                                value: cubit
                                                                    .pricesRoundTrip[i]
                                                                ['price'].toInt());
                                                            cubit.changeVehicleTypeRoundTrip(value: cubit.prices[i]['type']);
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (BuildContext context) => SelectPaymentMethodBottomSheetCustom(),
                                                            );
                                                          }
                                                        } else {
                                                          cubit.updateStateLessPageVar(change: () {
                                                            cubit.selectedPriceNumber = i;
                                                          },);
                                                          cubit.changePrice(
                                                              value: cubit
                                                                  .prices[i]
                                                              ['price'].toInt());
                                                          cubit.changeVehicleType(value: cubit.prices[i]['type']);
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (BuildContext context) => SelectPaymentMethodBottomSheetCustom(),
                                                          );
                                                        }

                                                      },
                                                      passengersNumber:
                                                      cubit.pricesRoundTrip[i]
                                                      ['passengers'],
                                                      price: cubit.pricesRoundTrip[i]
                                                      ['price'].toInt(),
                                                      taxiType: cubit.pricesRoundTrip[
                                                      i]
                                                      ['type'] ==
                                                          'sedan'
                                                          ? TaxiType.sedan
                                                          : TaxiType.van,
                                                      selected: cubit.selectedPriceNumberRoundTrip == i,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.changePricingMethod(
                                              value: 'fixed');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorData.whiteColor200,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeData.s16),
                                              border: cubit.pricingMethod ==
                                                      'fixed'
                                                  ? Border.all(
                                                      color: ColorData
                                                          .blueColor300,
                                                      width: Unit(context)
                                                          .width(SizeData.s1))
                                                  : Border.all(
                                                      color: ColorData
                                                          .grayColor200,
                                                      width: Unit(context)
                                                          .width(
                                                              SizeData.s1))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: SizeData.s12, vertical: SizeData.s16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  cubit.roundTrip && !secondPriceInRoundTrip ? LocaleKeys.kFirstTripFixedPrice.tr() : cubit.roundTrip && secondPriceInRoundTrip ? LocaleKeys.kSecondTripFixedPrice.tr() : LocaleKeys.kFixedPrice
                                                      .tr(),
                                                  style: StyleData
                                                      .textStyleGray600R14,
                                                ),
                                                Container(
                                                  width: Unit(context)
                                                      .width(SizeData.s16),
                                                  height: Unit(context)
                                                      .width(SizeData.s16),
                                                  decoration: BoxDecoration(
                                                      shape:
                                                          BoxShape.circle,
                                                      border: Border.all(
                                                        width: cubit.pricingMethod ==
                                                                'fixed'
                                                            ? Unit(context)
                                                                .width(
                                                                    SizeData
                                                                        .s4)
                                                            : Unit(context)
                                                                .width(
                                                                    SizeData
                                                                        .s1),
                                                        color: cubit.pricingMethod ==
                                                                'fixed'
                                                            ? ColorData
                                                                .blueColor400
                                                            : ColorData
                                                                .grayColor300,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
);
  }
}
