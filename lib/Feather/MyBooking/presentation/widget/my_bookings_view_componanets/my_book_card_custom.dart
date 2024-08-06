import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/bottom_sheets/invoice_for_finished_bookings_bottom_sheet_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/bottom_sheets/rating_bottom_sheet_custom.dart';

import 'package:public_app/Feather/MyBooking/presentation/widget/dialogs/modification_request_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class MyBookCardCustom extends StatelessWidget {

  final BookingModel model;
  MyBookCardCustom({super.key, required this.model,});

  late final MyBookingCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();
    }
    return model.timeState == TimeState.past ? Container(
      margin: EdgeInsets.all(SizeData.s8),
      decoration: BoxDecoration(
        border: model.status! == Status.newOffer ? null : Border.all(
          color: model.status! == Status.uncompleted ? ColorData.dangerColor400 : ColorData.grayColor200,
          width: model.status! == Status.uncompleted ? Unit(context).width(SizeData.s2) : Unit(context).width(SizeData.s1),
        ),
        color: model.status! == Status.newOffer ? ColorData.primaryColor25 : null,
        borderRadius: BorderRadius.circular(SizeData.s16),
      ),
      padding: EdgeInsets.all(SizeData.s16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: SizeData.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: SizeData.s4),
                      child: Text(
                        'Taxi',
                        style: StyleData.textStyleGray600SB14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: SizeData.s8),
                      child: Text(
                        model.vehicleType! == TaxiType.van ? 'Van' : 'Sedan',
                        style: StyleData.textStyleGray400R12,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: model.status! == Status.confirmed ? ColorData.successColor50 :
                          model.status! == Status.cancelled ? ColorData.dangerColor50 :
                          model.status! == Status.cancelledByClient ? ColorData.dangerColor50 :
                          model.status! == Status.newOffer ? ColorData.customColor11 : ColorData.warningColor50,
                          borderRadius: BorderRadius.circular(SizeData.s16)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: SizeData.s8, vertical: SizeData.s2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(model.status! == Status.uncompleted)Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: CircleAvatar(
                              backgroundColor: ColorData.warningColor500,
                              radius: Unit(context).iconSize(SizeData.s3),
                            ),
                          ),
                          if(model.status! == Status.newOffer)Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: CircleAvatar(
                              backgroundColor: ColorData.customColor10,
                              radius: Unit(context).iconSize(SizeData.s3),
                            ),
                          ),
                          Text(
                            model.status! == Status.confirmed ? 'Confirmed' :
                            model.status! == Status.uncompleted ? 'Uncompleted' :
                            model.status! == Status.cancelled ? 'Cancelled' :
                            model.status! == Status.cancelledByClient ? 'Cancelled By Client' :
                            model.status! == Status.waitingConfirmation ? 'Waiting Confirmation' : 'New Offer',
                            style: model.status! == Status.confirmed ? StyleData.textStyleSuccess700R12 :
                            model.status! == Status.cancelled ? StyleData.textStyleDanger700R12 :
                            model.status! == Status.newOffer ? StyleData.textStyleBlue700M12 : StyleData.textStyleWarning700R12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if(model.status! == Status.confirmed || model.status! == Status.waitingConfirmation)DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset(
                      Assets.myBookingMoreIcon,
                      height: Unit(context).iconSize(SizeData.s24),
                      width: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.grayColor800,
                      fit: BoxFit.scaleDown,
                    ),
                    items: [
                      ...[
                        {
                          'text': 'Rebook',
                        },
                        if(model.status! == Status.confirmed){
                          'text': 'Invoice',
                        },
                        if(model.status! == Status.confirmed){
                          'text': 'Review',
                        }
                      ].map(
                            (item) => DropdownMenuItem(
                          value: item['text'],
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempOptionsDropButton = item['text'] as String;
                            },);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s8),
                              child: Text(
                                item['text'] as String,
                                style: StyleData.textStyleCustom5R14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if ( value == 'Rebook'){
                        context.push(AppRouter.kRebookView, extra: {
                          'model': model
                        });
                      } else if  ( value == 'Invoice') {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                InvoiceForFinishedBookingsBottomSheetCustom(id: model.id!, cardOnlinePayment: model.payment! == Payment.cardOnLine,),
                            constraints: const BoxConstraints.expand()
                        );
                      } else if ( value == 'Review'){
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                RatingBottomSheetCustom(id: model.id!, pickUpAddress: model.departureLocation!, dropOffAddress: model.arrivalLocation!,),
                            constraints: const BoxConstraints.expand()
                        );
                      }
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: Unit(context).width(SizeData.s167),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeData.s6),
                        color: ColorData.whiteColor200,
                        boxShadow: ShadowData.boxShadow4
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled([
                          {
                            'text': 'Rebook',
                          },
                          if(model.status! == Status.confirmed){
                            'text': 'Invoice',
                          },
                          if(model.status! == Status.confirmed){
                            'text': 'Review',
                          }
                        ].length, Unit(context).height(SizeData.s46)),
                      ],
                    ),
                  ),
                ),
                if(model.status! == Status.cancelled || model.status! == Status.cancelledByClient || model.status! == Status.uncompleted || model.status! == Status.newOffer)DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset(
                      Assets.myBookingMoreIcon,
                      height: Unit(context).iconSize(SizeData.s24),
                      width: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.whiteColor500,
                      fit: BoxFit.scaleDown,
                    ),
                    items: [
                      ...[
                        {
                          'text': ' ',
                        },
                      ].map(
                            (item) => DropdownMenuItem(
                          value: item['text'],
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempOptionsDropButton = item['text'] as String;
                            },);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s8),
                              child: Text(
                                item['text'] as String,
                                style: StyleData.textStyleCustom5R14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {

                    },
                    dropdownStyleData: DropdownStyleData(
                      width: Unit(context).width(SizeData.s167),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeData.s6),
                          color: ColorData.whiteColor200,
                          boxShadow: ShadowData.boxShadow4
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled([
                          {
                            'text': ' ',
                          }
                        ].length, Unit(context).height(SizeData.s46)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorData.primaryColor800,
              borderRadius: BorderRadius.circular(SizeData.s6)
            ),
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          Assets.userCalendarIcon,
                        color: ColorData.primaryColor200,
                        width: Unit(context).iconSize(SizeData.s20),
                        height: Unit(context).iconSize(SizeData.s20),
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                          DateFormat('EEE dd/MM/yyyy').format(model.departureDateTime!),
                        style: StyleData.textStylePrimary200R14,
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  width: Unit(context).width(SizeData.s0_5),
                  color: ColorData.primaryColor200,
                  endIndent: Unit(context).height(SizeData.s8),
                  indent: Unit(context).height(SizeData.s8),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.bookTaxiClockIcon,
                        color: ColorData.primaryColor200,
                        width: Unit(context).iconSize(SizeData.s20),
                        height: Unit(context).iconSize(SizeData.s20),
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: model.departureDateTime!.hour, minute: model.departureDateTime!.minute), alwaysUse24HourFormat: false),
                        style: StyleData.textStylePrimary200R14,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Booking details',
                          style: StyleData.textStyleGray600M12,
                        ),
                        if(model.status! != Status.confirmed && model.status! != Status.cancelledByClient && model.status! != Status.cancelled)Container(
                          decoration: BoxDecoration(
                              color: ColorData.dangerColor50,
                              borderRadius: BorderRadius.circular(SizeData.s16)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: SizeData.s8, vertical: SizeData.s2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: SizeData.s8),
                                child: CircleAvatar(
                                  backgroundColor: ColorData.dangerColor400,
                                  radius: Unit(context).iconSize(SizeData.s3),
                                ),
                              ),
                              Text(
                                'Expiry',
                                style: StyleData.textStyleDanger400M12,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorData.primaryColor50,
                      borderRadius: BorderRadius.circular(SizeData.s8),
                    ),
                    padding: EdgeInsets.all(SizeData.s8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Unit(context).width(SizeData.s68),
                                child: Text(
                                  'Pick up',
                                  style: StyleData.textStyleGray600M12,
                                ),
                              ),
                              Container(
                                width: Unit(context).width(SizeData.s1),
                                height: Unit(context).height(SizeData.s20),
                                color: ColorData.primaryColor200,
                              ),
                              SizedBox(
                                width: Unit(context).width(SizeData.s165),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: SizeData.s8),
                                      child: SvgPicture.asset(
                                        Assets.myBookingLocationIcon,
                                        width: Unit(context).iconSize(SizeData.s20),
                                        height: Unit(context).iconSize(SizeData.s20),
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s137),
                                      child: Text(
                                        model.departureLocation!,
                                        style: StyleData.textStyleGray700M12,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: SizeData.s8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Unit(context).width(SizeData.s68),
                                child: Text(
                                  'Drop off',
                                  style: StyleData.textStyleGray600M12,
                                ),
                              ),
                              Container(
                                width: Unit(context).width(SizeData.s1),
                                height: Unit(context).height(SizeData.s20),
                                color: ColorData.primaryColor200,
                              ),
                              SizedBox(
                                width: Unit(context).width(SizeData.s165),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: SizeData.s8),
                                      child: SvgPicture.asset(
                                        Assets.myBookingLocationIcon,
                                        width: Unit(context).iconSize(SizeData.s20),
                                        height: Unit(context).iconSize(SizeData.s20),
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s137),
                                      child: Text(
                                        model.arrivalLocation!,
                                        style: StyleData.textStyleGray700M12,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: Unit(context).height(SizeData.s0_5),
            color: ColorData.customColor6,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: Text(
                      'Info Details',
                      style: StyleData.textStyleGray600M12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: SizeData.s20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Passengers',
                                style: StyleData.textStyleGray700M12,
                              ),
                              Text(
                                '${model.numberOfPassengers}x',
                                style: StyleData.textStyleGray400M12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Special Luggages',
                              style: StyleData.textStyleGray700M12,
                            ),
                            Text(
                              '${model.numberOfSpecialLuggages}x',
                              style: StyleData.textStyleGray400M12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: SizeData.s20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Luggages',
                                style: StyleData.textStyleGray700M12,
                              ),
                              Text(
                                '${model.numberOfLuggages}x',
                                style: StyleData.textStyleGray400M12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pets',
                              style: StyleData.textStyleGray700M12,
                            ),
                            Text(
                              '${model.numberOfPets}x',
                              style: StyleData.textStyleGray400M12,
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
          Divider(
            height: Unit(context).height(SizeData.s0_5),
            color: ColorData.customColor6,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: StyleData.textStyleGray600M12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                        child: Text(
                          model.payment == Payment.cardOnBoard ? 'Credit Card on Board' : model.payment == Payment.cardOnLine ? 'Credit Card Online' : 'Cash',
                          style: StyleData.textStyleGray600B12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(model.status! == Status.newOffer)Text(
                        'New Offer',
                        style: StyleData.textStyleCustom12R12,
                      ),
                      Text(
                        '${model.price}€',
                        style: StyleData.textStyleCustom7B16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          MainButtonCustom(
            text: model.status! == Status.uncompleted ? 'Complete Your Booking' :
            model.status! == Status.newOffer ? 'Rebook' :'View Details',
            textStyle: model.status! == Status.uncompleted ? StyleData.textStyleCustom8M14 :
            model.status! == Status.confirmed ? StyleData.textStyleCustom7M14 :
            model.status! == Status.waitingConfirmation ? StyleData.textStyleCustom7M14 :StyleData.textStyleGray300M14,
            color: model.status! == Status.uncompleted ? ColorData.grayColor300 : null,
            border: model.status! == Status.confirmed ? Border.all(
              width: Unit(context).width(SizeData.s1),
              color: ColorData.customColor7
            ) : model.status! == Status.waitingConfirmation ? Border.all(
                width: Unit(context).width(SizeData.s1),
                color: ColorData.customColor7
            ) : model.status! == Status.uncompleted ? null : Border.all(
                width: Unit(context).width(SizeData.s1),
                color: ColorData.grayColor300
            ),
            onTap: () {
              if (model.status == Status.confirmed || model.status == Status.waitingConfirmation) {
                context.push(AppRouter.kBookingDetailsView, extra: {
                  'model': model
                });
              }
            },
          )
        ],
      ),
    ) : Container(
      margin: EdgeInsets.all(SizeData.s8),
      decoration: BoxDecoration(
        border: model.status! == Status.newOffer ? null : Border.all(
          color: model.status! == Status.uncompleted ? ColorData.dangerColor400 : ColorData.grayColor200,
          width: model.status! == Status.uncompleted ? Unit(context).width(SizeData.s2) : Unit(context).width(SizeData.s1),
        ),
        color: model.status! == Status.newOffer ? ColorData.primaryColor25 : null,
        borderRadius: BorderRadius.circular(SizeData.s16),
      ),
      padding: EdgeInsets.all(SizeData.s16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: SizeData.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: SizeData.s4),
                      child: Text(
                        'Taxi',
                        style: StyleData.textStyleGray600SB14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: SizeData.s8),
                      child: Text(
                        model.vehicleType! == TaxiType.van ? 'Van' : 'Sedan',
                        style: StyleData.textStyleGray400R12,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: model.status! == Status.confirmed ? ColorData.successColor50 :
                          model.status! == Status.cancelled ? ColorData.dangerColor50 :
                          model.status! == Status.cancelledByClient ? ColorData.dangerColor50 :
                          model.status! == Status.newOffer ? ColorData.customColor11 : ColorData.warningColor50,
                          borderRadius: BorderRadius.circular(SizeData.s16)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: SizeData.s8, vertical: SizeData.s2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(model.status! == Status.uncompleted)Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: CircleAvatar(
                              backgroundColor: ColorData.warningColor500,
                              radius: Unit(context).iconSize(SizeData.s3),
                            ),
                          ),
                          if(model.status! == Status.newOffer)Padding(
                            padding: EdgeInsets.only(right: SizeData.s8),
                            child: CircleAvatar(
                              backgroundColor: ColorData.customColor10,
                              radius: Unit(context).iconSize(SizeData.s3),
                            ),
                          ),
                          Text(
                            model.status! == Status.confirmed ? 'Confirmed' :
                            model.status! == Status.uncompleted ? 'Uncompleted' :
                            model.status! == Status.cancelled ? 'Cancelled' :
                            model.status! == Status.cancelledByClient ? 'Cancelled By Client' :
                            model.status! == Status.waitingConfirmation ? 'Waiting Confirmation' : 'New Offer',
                            style: model.status! == Status.confirmed ? StyleData.textStyleSuccess700R12 :
                            model.status! == Status.cancelled ? StyleData.textStyleDanger700R12 :
                            model.status! == Status.newOffer ? StyleData.textStyleBlue700M12 : StyleData.textStyleWarning700R12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if(model.status! == Status.confirmed || model.status! == Status.uncompleted || model.status! == Status.waitingConfirmation || model.status! == Status.newOffer)DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset(
                      Assets.myBookingMoreIcon,
                      height: Unit(context).iconSize(SizeData.s24),
                      width: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.grayColor800,
                      fit: BoxFit.scaleDown,
                    ),
                    items: [
                      ...[
                        if(model.status! == Status.confirmed){
                          'text': 'Ticket',
                        },
                        if(model.status! == Status.confirmed){
                          'text': 'Invoice',
                        },
                        if(model.status! == Status.confirmed){
                          'text': 'Modification request',
                        },
                        if(model.status! == Status.uncompleted){
                          'text': 'Complete Booking',
                        },
                        if(model.status! == Status.newOffer){
                          'text': 'Accept',
                        },
                        {
                          'text': 'Cancel Request',
                        },
                      ].map(
                            (item) => DropdownMenuItem(
                          value: item['text'],
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempOptionsDropButton = item['text'] as String;
                            },);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s8),
                              child: Text(
                                item['text'] as String,
                                style: StyleData.textStyleCustom5R14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if ( value == 'Ticket' ) {
                        context.push(AppRouter.kTicketView, extra: {
                          'id': model.id
                        });
                      } else if ( value == 'Invoice' ) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                InvoiceForFinishedBookingsBottomSheetCustom(id: model.id!, cardOnlinePayment: model.payment == Payment.cardOnLine,));
                      } else if ( value == 'Modification request' ) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                ModificationRequestDialogCustom(id: model.id!,));
                      } else if ( value == 'Complete Booking' ) {
                        BookTaxiCubit.get(context).resetVarToCompleteBooking(model: model);
                        context.push(AppRouter.kFindDriverView, extra: {
                          'firstTrip': true,
                        });
                      } else if ( value == 'Accept' ) {
                        context.push(AppRouter.kAcceptOfferView, extra: {
                          'model': model
                        });
                      } else if ( value == 'Cancel Request' ) {
                        print(model.id);
                        context.push(AppRouter.kRequestCancelledView, extra: {
                          'id': model.id
                        });
                      }
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: Unit(context).width(SizeData.s167),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeData.s6),
                          color: ColorData.whiteColor200,
                          boxShadow: ShadowData.boxShadow4
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled([
                          if(model.status! == Status.confirmed){
                            'text': 'Ticket',
                          },
                          if(model.status! == Status.confirmed){
                            'text': 'Invoice',
                          },
                        ].length, Unit(context).height(SizeData.s46)),
                        ...List<double>.filled([
                          if(model.status! == Status.confirmed){
                            'text': 'Modification request',
                          },
                        ].length, Unit(context).height(SizeData.s92)),
                        ...List<double>.filled([
                          if(model.status! == Status.uncompleted){
                            'text': 'Complete Booking',
                          },
                          if(model.status! == Status.newOffer){
                            'text': 'Accept',
                          },
                          {
                            'text': 'Cancel Request',
                          },
                        ].length, Unit(context).height(SizeData.s46)),
                      ],
                    ),
                  ),
                ),
                if(model.status! == Status.cancelled || model.status! == Status.cancelledByClient)DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: SvgPicture.asset(
                      Assets.myBookingMoreIcon,
                      height: Unit(context).iconSize(SizeData.s24),
                      width: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.whiteColor500,
                      fit: BoxFit.scaleDown,
                    ),
                    items: [
                      ...[
                        {
                          'text': ' ',
                        },
                      ].map(
                            (item) => DropdownMenuItem(
                          value: item['text'],
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempOptionsDropButton = item['text'] as String;
                            },);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s8),
                              child: Text(
                                item['text'] as String,
                                style: StyleData.textStyleCustom5R14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {

                    },
                    dropdownStyleData: DropdownStyleData(
                      width: Unit(context).width(SizeData.s167),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeData.s6),
                          color: ColorData.whiteColor200,
                          boxShadow: ShadowData.boxShadow4
                      ),
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled([
                          {
                            'text': ' ',
                          }
                        ].length, Unit(context).height(SizeData.s46)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorData.primaryColor800,
                borderRadius: BorderRadius.circular(SizeData.s6)
            ),
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.userCalendarIcon,
                        color: ColorData.primaryColor200,
                        width: Unit(context).iconSize(SizeData.s20),
                        height: Unit(context).iconSize(SizeData.s20),
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        DateFormat('EEE dd/MM/yyyy').format(model.departureDateTime!),
                        style: StyleData.textStylePrimary200R14,
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  width: Unit(context).width(SizeData.s0_5),
                  color: ColorData.primaryColor200,
                  endIndent: Unit(context).height(SizeData.s8),
                  indent: Unit(context).height(SizeData.s8),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.bookTaxiClockIcon,
                        color: ColorData.primaryColor200,
                        width: Unit(context).iconSize(SizeData.s20),
                        height: Unit(context).iconSize(SizeData.s20),
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: model.departureDateTime!.hour, minute: model.departureDateTime!.minute), alwaysUse24HourFormat: false),
                        style: StyleData.textStylePrimary200R14,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Booking details',
                          style: StyleData.textStyleGray600M12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: ColorData.primaryColor50,
                        borderRadius: BorderRadius.circular(SizeData.s8),
                      ),
                      padding: EdgeInsets.all(SizeData.s8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Unit(context).width(SizeData.s68),
                                  child: Text(
                                    'Pick up',
                                    style: StyleData.textStyleGray600M12,
                                  ),
                                ),
                                Container(
                                  width: Unit(context).width(SizeData.s1),
                                  height: Unit(context).height(SizeData.s20),
                                  color: ColorData.primaryColor200,
                                ),
                                SizedBox(
                                  width: Unit(context).width(SizeData.s165),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: SizeData.s8),
                                        child: SvgPicture.asset(
                                          Assets.myBookingLocationIcon,
                                          width: Unit(context).iconSize(SizeData.s20),
                                          height: Unit(context).iconSize(SizeData.s20),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Unit(context).width(SizeData.s137),
                                        child: Text(
                                          model.departureLocation!,
                                          style: StyleData.textStyleGray700M12,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: SizeData.s8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Unit(context).width(SizeData.s68),
                                  child: Text(
                                    'Drop off',
                                    style: StyleData.textStyleGray600M12,
                                  ),
                                ),
                                Container(
                                  width: Unit(context).width(SizeData.s1),
                                  height: Unit(context).height(SizeData.s20),
                                  color: ColorData.primaryColor200,
                                ),
                                SizedBox(
                                  width: Unit(context).width(SizeData.s165),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: SizeData.s8),
                                        child: SvgPicture.asset(
                                          Assets.myBookingLocationIcon,
                                          width: Unit(context).iconSize(SizeData.s20),
                                          height: Unit(context).iconSize(SizeData.s20),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Unit(context).width(SizeData.s137),
                                        child: Text(
                                          model.arrivalLocation!,
                                          style: StyleData.textStyleGray700M12,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: Unit(context).height(SizeData.s0_5),
            color: ColorData.customColor6,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: Text(
                      'Info Details',
                      style: StyleData.textStyleGray600M12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: SizeData.s20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Passengers',
                                style: StyleData.textStyleGray700M12,
                              ),
                              Text(
                                '${model.numberOfPassengers}x',
                                style: StyleData.textStyleGray400M12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Special Luggages',
                              style: StyleData.textStyleGray700M12,
                            ),
                            Text(
                              '${model.numberOfSpecialLuggages}x',
                              style: StyleData.textStyleGray400M12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: SizeData.s20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Luggages',
                                style: StyleData.textStyleGray700M12,
                              ),
                              Text(
                                '${model.numberOfLuggages}x',
                                style: StyleData.textStyleGray400M12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pets',
                              style: StyleData.textStyleGray700M12,
                            ),
                            Text(
                              '${model.numberOfPets}x',
                              style: StyleData.textStyleGray400M12,
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
          Divider(
            height: Unit(context).height(SizeData.s0_5),
            color: ColorData.customColor6,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: StyleData.textStyleGray600M12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                        child: Text(
                          model.payment == Payment.cardOnBoard ? 'Credit Card on Board' : model.payment == Payment.cardOnLine ? 'Credit Card Online' : 'Cash',
                          style: StyleData.textStyleGray600B12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(model.status! == Status.newOffer)Text(
                        'New Offer',
                        style: StyleData.textStyleCustom12R12,
                      ),
                      Text(
                        '${model.price}€',
                        style: StyleData.textStyleCustom7B16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          MainButtonCustom(
            text: model.status! == Status.uncompleted ? 'Complete Your Booking' :
            model.status! == Status.newOffer ? 'Accept' :'View Details',
            textStyle: model.status! == Status.uncompleted ? StyleData.textStyleCustom8M14 :
            model.status! == Status.cancelledByClient ? StyleData.textStyleGray300M14 :
            model.status! == Status.cancelled ? StyleData.textStyleGray300M14 : StyleData.textStyleCustom7M14,
            color: model.status! == Status.uncompleted ? ColorData.primaryColor500 : null,
            border: model.status! == Status.uncompleted ? null :
                    model.status! == Status.cancelled ?  Border.all(
                        width: Unit(context).width(SizeData.s1),
                        color: ColorData.grayColor300
                    ) :
                    model.status! == Status.cancelledByClient ?  Border.all(
                        width: Unit(context).width(SizeData.s1),
                        color: ColorData.grayColor300
                    ) : Border.all(
                        width: Unit(context).width(SizeData.s1),
                        color: ColorData.customColor7
                    ) ,
            onTap: () {
              if (model.status! == Status.uncompleted) {
                BookTaxiCubit.get(context).resetVarToCompleteBooking(model: model);
                context.push(AppRouter.kFindDriverView, extra: {
                  'firstTrip': true,
                });
              } else if (model.status! == Status.newOffer) {
                context.push(AppRouter.kAcceptOfferView, extra: {
                  'model': model
                });
              } else {
                if (model.status == Status.confirmed || model.status == Status.waitingConfirmation) {
                  context.push(AppRouter.kBookingDetailsView, extra: {
                    'model': model
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }
}

