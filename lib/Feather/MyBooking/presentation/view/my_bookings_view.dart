import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/my_bookings_view_componanets/my_book_card_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/generated/assets.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class MyBookingsView extends StatelessWidget {

  MyBookingsView({super.key,});

  final ScrollController scrollController = ScrollController();

  GroupButtonController buttonController = GroupButtonController(selectedIndex: 0);

  /*List<String> sort = ['state', 'date'];*/

  late final MyBookingCubit cubit;

  bool first = true;

  void onScroll() {
    /*if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent && cubit.currentPageInMyBooking < cubit.totalPageInMyBooking) {
      cubit.updateStateLessPageVar(change: () {
        cubit.currentPageInMyBooking++;
      },);
      cubit.getMyBookings();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();
      buttonController = GroupButtonController(selectedIndex: cubit.tempPageIndex);
      cubit.updateStateLessPageVar(change: () {
        cubit.myBookingLoaded = false;
      });
      cubit.getMyBookings();
      /*scrollController.addListener(onScroll);*/
    }
    return BlocBuilder<MyBookingCubit, MyBookingState>(
  builder: (context, state) {
    if (state is SuccessMyBookingState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.myBookingLoaded = true;
      });
    }
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          const LayoutAppBarCustom(title: 'My Booking',iconOneType: IconOneType.empty,),
          Container(
            margin: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeData.s16),
              color: ColorData.whiteColor200,
              boxShadow: cubit.myBookings.isEmpty ? ShadowData.boxShadow1 : null
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: cubit.myBookings.isNotEmpty ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!cubit.myBookingLoaded)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if(cubit.myBookingLoaded && cubit.myBookings.isNotEmpty)Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(SizeData.s8),
                        decoration: BoxDecoration(
                            color: ColorData.primaryColor50,
                            borderRadius: BorderRadius.circular(SizeData.s8)
                        ),
                        padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                        child: GroupButton(
                          buttons: const ['Upcoming', 'Past'],
                          options: GroupButtonOptions(
                              borderRadius: BorderRadius.circular(SizeData.s8),
                              groupingType: GroupingType.row,
                              mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                              selectedColor: ColorData.primaryColor400,
                              unselectedTextStyle: StyleData.textStyleGray400R12,
                              selectedTextStyle: StyleData.textStyleWhite200R12,
                              buttonWidth: Unit(context).width(SizeData.s140),
                              unselectedColor: ColorData.primaryColor50,
                              selectedShadow: [],
                              unselectedShadow: [],
                          ),
                          controller: buttonController,
                          onSelected: (value, index, isSelected) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempPageIndex = index;
                              cubit.myBookingLoaded = false;
                            },);
                            cubit.getMyBookings(changeTab: true);
                          },
                        ),
                      ),
                      Timeago(builder: (context, value) => Text(
                          'Last update $value',
                          style: StyleData.textStyleGray400R12), date: cubit.lastUpdate),
                      /*Padding(
                        padding: EdgeInsets.all(SizeData.s8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                'All Appointments',
                              style: StyleData.textStyleGray600SB14,
                            ),
                            SizedBox(
                              width: Unit(context).width(SizeData.s147),
                              height: Unit(context).height(SizeData.s32),
                              child: DropdownButtonFormField<String>(
                                items: sort.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                decoration: InputDecoration(
                                  border:
                                  BorderData.outlineInputBorderGray200W1R5,
                                  enabledBorder:
                                  BorderData.outlineInputBorderGray200W1R5,
                                  focusedBorder:
                                  BorderData.outlineInputBorderGray200W1R5,
                                  errorBorder:
                                  BorderData.outlineInputBorderGray200W1R5,
                                  focusedErrorBorder:
                                  BorderData.outlineInputBorderGray200W1R5,
                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: SizeData.s6),

                                ),
                                hint: Center(
                                  child: Text(
                                    'Sort by',
                                    style: StyleData.textStyleGray600R12,
                                  ),
                                ),
                                onChanged: (value) {
                                  cubit.updateStateLessPageVar(change: () {
                                    cubit.tempSort = value!;
                                  },);
                                },
                                autofocus: false,
                              ),
                            )
                          ],
                        ),
                      ),*/
                      Expanded(
                        child: RefreshIndicator.adaptive(
                          onRefresh: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.myBookingLoaded = false;
                            });
                            cubit.getMyBookings(changeTab: true);
                            return Future.value(null);
                          },
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: cubit.myBookings.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => MyBookCardCustom(
                                model: cubit.myBookings[index]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if(cubit.myBookingLoaded && cubit.myBookings.isEmpty)Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(SizeData.s8),
                      decoration: BoxDecoration(
                          color: ColorData.primaryColor50,
                          borderRadius: BorderRadius.circular(SizeData.s8)
                      ),
                      padding: EdgeInsets.all(SizeData.s8),
                      child: GroupButton(
                        buttons: const ['Upcoming', 'Past'],
                        options: GroupButtonOptions(
                          borderRadius: BorderRadius.circular(SizeData.s8),
                          groupingType: GroupingType.row,
                          mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                          selectedColor: ColorData.primaryColor400,
                          unselectedTextStyle: StyleData.textStyleGray400R12,
                          selectedTextStyle: StyleData.textStyleWhite200R12,
                          buttonWidth: Unit(context).width(SizeData.s140),
                          unselectedColor: ColorData.primaryColor50,
                          selectedShadow: [],
                          runSpacing: 0,
                          spacing: 0,
                          unselectedShadow: [],
                        ),
                        controller: buttonController,
                        onSelected: (value, index, isSelected) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempPageIndex = index;
                            cubit.myBookingLoaded = false;
                          },);
                          cubit.getMyBookings(changeTab: true);
                        },
                      ),
                    ),
                    LottieBuilder.asset(
                      Assets.lottieEmptyBookings,
                      height: Unit(context).width(SizeData.s200),
                      width: Unit(context).width(SizeData.s200),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeData.s8),
                      child: Text(
                        'Not found any Reservation yet',
                        style: StyleData.textStyleGray600SB16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeData.s8),
                      child: Text(
                        'Sorry you don’t make any requests yet, Click on the Home Page and let’s create a new request',
                        style: StyleData.textStyleGray500R14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: SizeData.s8, left: SizeData.s8, bottom: SizeData.s8),
                      child: MainButtonCustom(
                        onTap: () {
                          UserCubit.get(context).changeCurrentIndexLayout(0);
                        },
                        text: 'Create Reservation',
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                      ),
                    ),
                  ],
                )
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

