import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/buttons/out_line_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/shape/ticket_shape_custom.dart';
import 'package:public_app/generated/assets.dart';

class TicketView extends StatelessWidget {

  final String id;
  TicketView({super.key, this.id = ''});

  late final BookTaxiCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      cubit.updateStateLessPageVar(change: () {
        cubit.ticketLoaded = false;
      });
      cubit.getTicketDetails(id: id);
    }
    return BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
    if (state is SuccessTicketState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.ticketLoaded = true;
      });
    }
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Padding(
        padding: EdgeInsets.all(SizeData.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeData.s28),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeData.s8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: Unit(context).iconSize(SizeData.s48),
                            width: Unit(context).iconSize(SizeData.s48),
                            child: SvgPicture.asset(
                              Assets.userColoredLogo,
                              width: Unit(context).width(SizeData.s42),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        LocaleKeys.kTaxiService.tr(),
                        style: StyleData.textStyleGray700M14,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // TODO: share ticket
                            },
                            child: Container(
                              width: Unit(context).iconSize(SizeData.s40),
                              height: Unit(context).iconSize(SizeData.s40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeData.s8),
                                  color: ColorData.primaryColor50
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.bookTaxiShareIcon,
                                  width: Unit(context).iconSize(SizeData.s24),
                                  height: Unit(context).iconSize(SizeData.s24),
                                  color: ColorData.primaryColor500,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (!cubit.ticketLoaded)const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (cubit.ticketLoaded)Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.kYourETicketReady.tr(),
                          style: StyleData.textStyleBlue400M14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorData.whiteColor200,
                              borderRadius: BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1
                          ),
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.kPickUp.tr(),
                                          style: StyleData.textStyleGray400R12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Text(
                                            MaterialLocalizations.of(context).formatTimeOfDay(cubit.ticket!.pickUpTime!, alwaysUse24HourFormat: true),
                                            style: StyleData.textStyleGray500M12,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('d MMM, yyyy').format(cubit.ticket!.pickUpDate!),
                                          style: StyleData.textStyleGray500M12,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.bookTaxiTicketArrowIcon,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SvgPicture.asset(
                                          Assets.bookTaxiCarFrontViewIcon,
                                          width: Unit(context).iconSize(SizeData.s24),
                                          height: Unit(context).iconSize(SizeData.s24),
                                          color: ColorData.primaryColor500,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.kDropOff.tr(),
                                          style: StyleData.textStyleGray400R12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Text(
                                            MaterialLocalizations.of(context).formatTimeOfDay(cubit.ticket!.dropOffTime!, alwaysUse24HourFormat: true),
                                            style: StyleData.textStyleGray500M12,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('d MMM, yyyy').format(cubit.ticket!.dropOffDate!),
                                          style: StyleData.textStyleGray500M12,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Unit(context).width(SizeData.s343),
                                decoration: ShapeDecoration(
                                    shape: TicketShapeCustom(
                                      radius: SizeData.s16,
                                      fillColor: ColorData.whiteColor200,
                                      borderColor: ColorData.whiteColor200,
                                      borderWidth: 0,
                                      bottomLeft: true,
                                      bottomRight: true,
                                      topLeft: false,
                                      topRight: false,
                                    ),
                                    shadows: ShadowData.boxShadow1
                                ),
                                padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(SizeData.s4),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.kName.tr(),
                                                    style: StyleData.textStyleGray400R12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: SizeData.s6),
                                                    child: Text(
                                                      cubit.ticket!.name!,
                                                      style: StyleData.textStyleGray700M12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(SizeData.s4),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.kBookingID.tr(),
                                                    style: StyleData.textStyleGray400R12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: SizeData.s6),
                                                    child: Text(
                                                      cubit.ticket!.bookingId!,
                                                      style: StyleData.textStyleGray700M12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(SizeData.s4),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.kEmail.tr(),
                                                    style: StyleData.textStyleGray400R12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: SizeData.s6),
                                                    child: Text(
                                                      cubit.ticket!.email!,
                                                      style: StyleData.textStyleGray700M12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(SizeData.s4),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ' ',
                                                    style: StyleData.textStyleGray400R12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: SizeData.s6),
                                                    child: Text(
                                                      ' ',
                                                      style: StyleData.textStyleGray700M12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Unit(context).height(3.5),
                                width: Unit(context).width(SizeData.s314),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Unit(context).height(3.5),
                                      width: Unit(context).width(SizeData.s4),
                                      color: ColorData.grayColor200,
                                    ),
                                    for (int i = 0; i < 24; i++)...[
                                      Container(
                                        height: Unit(context).height(3.5),
                                        width: Unit(context).width(SizeData.s8),
                                        color: ColorData.grayColor200,
                                      ),
                                    ],
                                    Container(
                                      height: Unit(context).height(3.5),
                                      width: Unit(context).width(SizeData.s4),
                                      color: ColorData.grayColor200,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Unit(context).width(SizeData.s343),
                                decoration: ShapeDecoration(
                                    shape: TicketShapeCustom(
                                      radius: SizeData.s16,
                                      fillColor: ColorData.whiteColor200,
                                      borderColor: ColorData.whiteColor200,
                                      borderWidth: 0,
                                      bottomLeft: false,
                                      bottomRight: false,
                                      topLeft: true,
                                      topRight: true,
                                    ),
                                    shadows: ShadowData.boxShadow1
                                ),
                                padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.kPassengers.tr(),
                                                  style: StyleData.textStyleGray400R12,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: SizeData.s4),
                                                  child: Text(
                                                    cubit.ticket!.numberOfPassengers!.toString(),
                                                    style: StyleData.textStyleBlue400M12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.kLuggages.tr(),
                                                  style: StyleData.textStyleGray400R12,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: SizeData.s4),
                                                  child: Text(
                                                    cubit.ticket!.numberOfLuggages!.toString(),
                                                    style: StyleData.textStyleBlue400M12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.kSpecialLuggages.tr(),
                                                  style: StyleData.textStyleGray400R12,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: SizeData.s4),
                                                  child: Text(
                                                    cubit.ticket!.numberOfSpecialLuggages!.toString(),
                                                    style: StyleData.textStyleBlue400M12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.kPets.tr(),
                                                  style: StyleData.textStyleGray400R12,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: SizeData.s4),
                                                  child: Text(
                                                    cubit.ticket!.numberOfPets!.toString(),
                                                    style: StyleData.textStyleBlue400M12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            LocaleKeys.kTotal.tr(),
                                            style: StyleData.textStyleGray700SB16,
                                          ),
                                          Text(
                                            '€${cubit.ticket!.totalPrice!}',
                                            style: StyleData.textStyleGray700SB14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: BarcodeWidget(
                                        barcode: Barcode.isbn(),
                                        data: cubit.ticket!.barCode!,
                                        height: Unit(context).height(SizeData.s100),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (cubit.ticketLoaded)Padding(
              padding: EdgeInsets.only(bottom: SizeData.s8),
              child: MainButtonCustom(
                onTap: () {
                  // TODO: download ticket
                },
                text: LocaleKeys.kDownloadTicket.tr(),
                textStyle: StyleData.textStylePrimary50M16,
                color: ColorData.primaryColor1000,
              ),
            ),
            if (cubit.ticketLoaded)Padding(
              padding: EdgeInsets.only(bottom: SizeData.s8),
              child: OutLineButtonCustom(
                onTap: () {
                  context.pop();
                },
                text: LocaleKeys.kBack.tr(),
                icon: Icons.arrow_back_rounded,
                textFirstIfIcon: true,
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
