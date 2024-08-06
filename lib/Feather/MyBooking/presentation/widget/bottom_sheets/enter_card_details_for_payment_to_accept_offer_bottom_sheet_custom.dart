import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/payment_failed_dialog_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/generated/assets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';


class EnterCardDetailsForPaymentToAcceptOfferBottomSheetCustom extends StatelessWidget {

  final BookingModel model;
  EnterCardDetailsForPaymentToAcceptOfferBottomSheetCustom({super.key, required this.model});

  late final MyBookingCubit cubit;

  bool first = true;

  TextEditingController cardholdersNameController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController expireDateController = MaskedTextController(
      mask: '0000/00');

  TextEditingController cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();

      cardholdersNameController.text = cubit.tempCardholdersName;
      cardNumberController.text = cubit.tempNumber;
      expireDateController.text = '${cubit.tempYear}/${cubit.tempMonth}';
      cvcController.text = cubit.tempCvc;
    }
    return BlocBuilder<MyBookingCubit, MyBookingState>(
      builder: (context, state) {
        if (state is SuccessCardOnlinePaymentState) {
          cubit.updateStateLessPageVar(change: () {
            cubit.paymentDetailsSanded = true;
            cubit.offerAcceptSanded = false;
          },);
          cubit.acceptOffer(id: model.id!);
          context.pop();
        }
        if (state is FiledCardOnlinePaymentState) {
          cubit.updateStateLessPageVar(change: () {
            cubit.paymentDetailsSanded = true;
            cubit.offerAcceptSanded = true;
          },);
          context.pop();
          showDialog(context: context, builder: (context) => const PaymentFailedDialogCustom());
        }
        return Container(
          decoration: BoxDecoration(
            color: ColorData.whiteColor200,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeData.s16),
                topLeft: Radius.circular(SizeData.s16)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Scaffold(
            backgroundColor: ColorData.whiteColor200,
            body: Container(
              padding: EdgeInsets.all(SizeData.s12),
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
                            LocaleKeys.kPayment.tr(),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: SizeData.s4),
                        child: Text(
                          LocaleKeys.kChooseTypeOfCard.tr(),
                          style: StyleData.textStyleGray600R14,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeData.s4),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.updateStateLessPageVar(change: () {
                                    cubit.cardType = 'visa';
                                  });
                                },
                                child: Container(
                                  width: Unit(context).width(SizeData.s73),
                                  decoration: BoxDecoration(
                                    color: cubit.cardType == 'visa'
                                        ? ColorData.primaryColor50
                                        : null,
                                    border: cubit.cardType == 'visa'
                                        ? Border.all(
                                      color: ColorData.primaryColor500,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    )
                                        : Border.all(
                                      color: ColorData.primaryColor50,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(SizeData.s8),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.bookTaxiVisaLogo,
                                    width: Unit(context).width(SizeData.s73),
                                    height:
                                    Unit(context).height(SizeData.s48),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeData.s4),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.updateStateLessPageVar(change: () {
                                    cubit.cardType = 'master';
                                  });
                                },
                                child: Container(
                                  width: Unit(context).width(SizeData.s73),
                                  decoration: BoxDecoration(
                                    color: cubit.cardType == 'master'
                                        ? ColorData.primaryColor50
                                        : null,
                                    border: cubit.cardType == 'master'
                                        ? Border.all(
                                      color: ColorData.primaryColor500,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    )
                                        : Border.all(
                                      color: ColorData.primaryColor50,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(SizeData.s8),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.bookTaxiMastercardLogo,
                                    width: Unit(context).width(SizeData.s73),
                                    height:
                                    Unit(context).height(SizeData.s48),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeData.s4),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.updateStateLessPageVar(change: () {
                                    cubit.cardType = 'paypal';
                                  });
                                },
                                child: Container(
                                  width: Unit(context).width(SizeData.s73),
                                  decoration: BoxDecoration(
                                    color: cubit.cardType == 'paypal'
                                        ? ColorData.primaryColor50
                                        : null,
                                    border: cubit.cardType == 'paypal'
                                        ? Border.all(
                                      color: ColorData.primaryColor500,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    )
                                        : Border.all(
                                      color: ColorData.primaryColor50,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(SizeData.s8),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.bookTaxiPaypalLogo,
                                    width: Unit(context).width(SizeData.s73),
                                    height:
                                    Unit(context).height(SizeData.s48),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeData.s4),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.updateStateLessPageVar(change: () {
                                    cubit.cardType = 'apple';
                                  });
                                },
                                child: Container(
                                  width: Unit(context).width(SizeData.s73),
                                  decoration: BoxDecoration(
                                    color: cubit.cardType == 'apple'
                                        ? ColorData.primaryColor50
                                        : null,
                                    border: cubit.cardType == 'apple'
                                        ? Border.all(
                                      color: ColorData.primaryColor500,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    )
                                        : Border.all(
                                      color: ColorData.primaryColor50,
                                      width: Unit(context)
                                          .width(SizeData.s2),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(SizeData.s8),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.bookTaxiApplePayLogo,
                                    width: Unit(context).width(SizeData.s73),
                                    height:
                                    Unit(context).height(SizeData.s48),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: SizeData.s4),
                        child: Text(
                          LocaleKeys.kCreditCardInformation.tr(),
                          style: StyleData.textStyleGray600R14,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeData.s8),
                      child: TextFormField(
                        controller: cardholdersNameController,
                        decoration: InputDecoration(
                          border: BorderData.outlineInputBorderGray200W1R8,
                          enabledBorder:
                          BorderData.outlineInputBorderGray200W1R8,
                          focusedBorder:
                          BorderData.outlineInputBorderBlue300W1R8,
                          errorBorder:
                          BorderData.outlineInputBorderDanger400W1R8,
                          focusedErrorBorder:
                          BorderData.outlineInputBorderDanger400W1R8,
                          hintText: LocaleKeys.kCardholdersName.tr(),
                          hintStyle: StyleData.textStyleGray400R12,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill this field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempCardholdersName = value;
                          },);
                        },
                        autofocus: false,
                        autofillHints: const [AutofillHints.creditCardName],
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeData.s8),
                      child: TextFormField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                            border: BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderBlue300W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kCardNumber.tr(),
                            hintStyle: StyleData.textStyleGray400R12,
                            counter: const SizedBox(
                              height: 0,
                            ),
                            counterText: ''),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill this field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempNumber = value;
                          },);
                        },
                        autofocus: false,
                        autofillHints: const [AutofillHints.creditCardNumber],
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        maxLength: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeData.s8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: SizeData.s4),
                              child: TextFormField(
                                controller: expireDateController,
                                decoration: InputDecoration(
                                  border:
                                  BorderData.outlineInputBorderGray200W1R8,
                                  enabledBorder:
                                  BorderData.outlineInputBorderGray200W1R8,
                                  focusedBorder:
                                  BorderData.outlineInputBorderBlue300W1R8,
                                  errorBorder: BorderData
                                      .outlineInputBorderDanger400W1R8,
                                  focusedErrorBorder: BorderData
                                      .outlineInputBorderDanger400W1R8,
                                  hintText: LocaleKeys.kExpireDate.tr(),
                                  hintStyle: StyleData.textStyleGray400R12,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please fill this field';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  cubit.updateStateLessPageVar(change: () {
                                    if (value.length>=5) {
                                      cubit.tempYear = value.split('/')[0];
                                      cubit.tempMonth = value.split('/')[1];
                                    } else {
                                      cubit.tempYear = value;
                                    }
                                  },);
                                },
                                autofocus: false,
                                autofillHints: const [
                                  AutofillHints.creditCardExpirationDate
                                ],
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: cvcController,
                              decoration: InputDecoration(
                                  border:
                                  BorderData.outlineInputBorderGray200W1R8,
                                  enabledBorder:
                                  BorderData.outlineInputBorderGray200W1R8,
                                  focusedBorder:
                                  BorderData.outlineInputBorderBlue300W1R8,
                                  errorBorder: BorderData
                                      .outlineInputBorderDanger400W1R8,
                                  focusedErrorBorder: BorderData
                                      .outlineInputBorderDanger400W1R8,
                                  hintText: LocaleKeys.kCvc.tr(),
                                  hintStyle: StyleData.textStyleGray400R12,
                                  counter: const SizedBox(
                                    height: 0,
                                  ),
                                  counterText: ''),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please fill this field';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cubit.updateStateLessPageVar(change: () {
                                  cubit.tempCvc = value;
                                },);
                              },
                              autofocus: false,
                              autofillHints: const [
                                AutofillHints.creditCardSecurityCode
                              ],
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
                              maxLength: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeData.s8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.kTotalPrice.tr(),
                            style: StyleData.textStyleGray400SB14,
                          ),
                          Text(
                            '€${model.price}',
                            style: StyleData.textStylePrimary500SB16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                      child: MainButtonCustom(
                        onTap: () {
                          cubit.changeNumber(value: cardNumberController.text);
                          cubit.changeCvc(value: cvcController.text);
                          cubit.changeMonth(
                              value: expireDateController.text.split('/')[1]);
                          cubit.changeYear(
                              value: expireDateController.text.split('/')[0]);

                          cubit.updateStateLessPageVar(change: () {
                            cubit.offerAcceptSanded = false;
                          });
                          cubit.cardOnlinePayment(id: model.id!);
                        },
                        text: LocaleKeys.kSubmit.tr(),
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                        loading: !cubit.offerAcceptSanded,
                        loadingColor: ColorData.primaryColor50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
