import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/payment_success_dialog_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/bottom_sheets/enter_card_details_for_payment_to_accept_offer_bottom_sheet_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/bottom_sheets/invoice_for_flexible_offer_accepted_bottom_sheet_custom.dart';
import 'package:public_app/generated/assets.dart';

class AcceptOfferView extends StatelessWidget {

  final BookingModel model;
  AcceptOfferView({super.key, required this.model,});

  late final MyBookingCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();
    }
    return BlocBuilder<MyBookingCubit, MyBookingState>(
      builder: (context, state) {
        if (state is SuccessOfferAcceptState) {
          if (model.payment == Payment.cardOnLine) {
            cubit.createInvoiceForCardOnline(id: model.id!);
          } else {
            cubit.createInvoiceForCardOnBoardAndCash(id: model.id!);
          }
        }

        if(state is SuccessOfferAcceptState) {
          showDialog(
              context: context,
              builder: (context) =>
                  PaymentSuccessDialogCustom(cardOnlinePayment: model.payment == Payment.cardOnLine));
        }
        return Scaffold(
          backgroundColor: ColorData.whiteColor200,
          body: Stack(
            children: [
              LayoutAppBarCustom(
                title: LocaleKeys.kTaxiBookingSummary.tr(),
                iconOneType: IconOneType.back,
                iconTwoType: IconTwoType.empty,
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                              decoration: BoxDecoration(
                                  color: ColorData.whiteColor200,
                                  borderRadius:
                                  BorderRadius.circular(SizeData.s16),
                                  boxShadow: ShadowData.boxShadow1),
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          model.vehicleType == TaxiType.sedan
                                              ? Assets.bookTaxiSedan
                                              : Assets.bookTaxiVan,
                                          width: Unit(context)
                                              .width(SizeData.s73),
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          width: Unit(context)
                                              .width(SizeData.s8),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.vehicleType == TaxiType.sedan
                                                  ? LocaleKeys.kSedan.tr()
                                                  : LocaleKeys.kVan.tr(),
                                              style: StyleData
                                                  .textStyleGray700M14,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              maxRating: 5,
                                              updateOnDrag: false,
                                              ignoreGestures: true,
                                              itemCount: 5,
                                              unratedColor:
                                              ColorData.grayColor200,
                                              itemSize: Unit(context)
                                                  .iconSize(SizeData.s12),
                                              itemPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                  SizeData.s1),
                                              itemBuilder: (context, _) =>
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: ColorData
                                                        .warningColor250,
                                                    size: Unit(context)
                                                        .iconSize(SizeData.s12),
                                                  ),
                                              onRatingUpdate: (rate) {},
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.kTotalTaxiPrice.tr(),
                                          style:
                                          StyleData.textStyleGray500R14,
                                        ),
                                        Text(
                                          '€${model.price}',
                                          style: StyleData
                                              .textStylePrimary500B16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                              decoration: BoxDecoration(
                                  color: ColorData.whiteColor200,
                                  borderRadius:
                                  BorderRadius.circular(SizeData.s16),
                                  boxShadow: ShadowData.boxShadow1,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: ColorData.primaryColor300,
                                          width: Unit(context)
                                              .width(SizeData.s2)))),
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.all(SizeData.s4),
                                        child: Text(
                                          LocaleKeys.kBookingDetails.tr(),
                                          style: StyleData
                                              .textStyleGray600M12,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  LocaleKeys.kPickUp.tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  model.departureLocation!,
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  LocaleKeys.kDate.tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  DateFormat(
                                                      'd MMM, yyyy')
                                                      .format(model.departureDateTime!),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  LocaleKeys.kDropOff,
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  model.arrivalLocation!,
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  LocaleKeys.kTime.tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  DateFormat('HH:mm').format(
                                                      model.departureDateTime!),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: ColorData
                                                      .primaryColor50,
                                                  width: Unit(context)
                                                      .width(
                                                      SizeData.s1)))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(SizeData.s4),
                                            child: Text(
                                              LocaleKeys.kInfoDetails.tr(),
                                              style: StyleData
                                                  .textStyleGray600M12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      LocaleKeys.kPassengers
                                                          .tr(),
                                                      style: StyleData
                                                          .textStyleGray600R12,
                                                    ),
                                                    Text(
                                                      (model.numberOfPassengers)
                                                          .toString(),
                                                      style: StyleData
                                                          .textStyleGray400R12,
                                                    ),
                                                    Text(
                                                      LocaleKeys
                                                          .kSpecialLuggages
                                                          .tr(),
                                                      style: StyleData
                                                          .textStyleGray600R12,
                                                    ),
                                                    Text(
                                                      (model.numberOfSpecialLuggages)
                                                          .toString(),
                                                      style: StyleData
                                                          .textStyleGray400R12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      LocaleKeys.kLuggages
                                                          .tr(),
                                                      style: StyleData
                                                          .textStyleGray600R12,
                                                    ),
                                                    Text(
                                                      (model.numberOfLuggages)
                                                          .toString(),
                                                      style: StyleData
                                                          .textStyleGray400R12,
                                                    ),
                                                    Text(
                                                      LocaleKeys.kPets.tr(),
                                                      style: StyleData
                                                          .textStyleGray600R12,
                                                    ),
                                                    Text(
                                                      (model.numberOfPets)
                                                          .toString(),
                                                      style: StyleData
                                                          .textStyleGray400R12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.all(SizeData.s4),
                                        child: Text(
                                          'Payment Method',
                                          style: StyleData
                                              .textStyleGray600M12,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            model.payment == Payment.cash
                                                ? Assets.bookTaxiCashIcon
                                                : Assets.bookTaxiCardIcon,
                                            width: Unit(context)
                                                .iconSize(SizeData.s24),
                                            height: Unit(context)
                                                .iconSize(SizeData.s24),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(
                                            width: Unit(context)
                                                .width(SizeData.s8),
                                          ),
                                          Text(
                                            model.payment == Payment.cash
                                                ? LocaleKeys.kCash.tr()
                                                : model.payment ==
                                                Payment.cardOnBoard
                                                ? LocaleKeys
                                                .kCreditCardOnBoard
                                                : LocaleKeys
                                                .kCreditCardOnline,
                                            style: StyleData
                                                .textStyleGray400R12,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: cubit.invoice,
                                      onChanged: (value) {
                                        if (value == true) {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) => InvoiceForFlexibleOfferAcceptedBottomSheetCustom(id: model.id!, cardOnlinePayment: model.payment == Payment.cardOnLine,),
                                          );
                                        } else {
                                          cubit.changeInvoice(value: false);
                                        }
                                      },
                                      activeColor: ColorData.blueColor400,
                                    ),
                                    Text(
                                      LocaleKeys.kDoYouNeedInvoice.tr(),
                                      style: StyleData.textStyleGray400R14,
                                    )
                                  ]),
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
                          if(model.payment == Payment.cardOnLine) {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => EnterCardDetailsForPaymentToAcceptOfferBottomSheetCustom(model: model),
                            );
                          } else {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.offerAcceptSanded = false;
                            },);
                            cubit.acceptOffer(id: model.id!);
                          }
                        },
                        text: LocaleKeys.kSend.tr(),
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                        loading: !cubit.offerAcceptSanded,
                        loadingColor: ColorData.primaryColor50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeData.s16),
                      child: MainButtonCustom(
                        onTap: () {
                          context.pop();
                        },
                        text: LocaleKeys.kCancel.tr(),
                        border: Border.all(
                            color: ColorData.dangerColor500,
                            width: Unit(context).width(SizeData.s1)),
                        textStyle: StyleData.textStyleDanger500M14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
