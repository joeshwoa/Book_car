import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:group_button/group_button.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/buttons/group_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/find_driver_view_componanets/time_picker_custom.dart';
import 'package:public_app/generated/assets.dart';
import 'package:table_calendar/table_calendar.dart';

class AddDepartureDateView extends StatelessWidget {

  final bool timeSection;
  final bool firstTrip;
  AddDepartureDateView({super.key, required this.timeSection, this.firstTrip = true,});

  late final BookTaxiCubit cubit;

  bool first = true;

  GroupButtonController buttonController = GroupButtonController(selectedIndex: 0);

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      cubit.updateStateLessPageVar(change: () {
        cubit.tempAddDateTimePageIndex = timeSection? 1 : 0;

        cubit.tempFocusedDate = cubit.date;
        cubit.tempFocusedDateRoundTrip = cubit.dateRoundTrip;
        cubit.tempSelectedDate = cubit.date;
        cubit.tempSelectedDateRoundTrip = cubit.dateRoundTrip;
        cubit.tempSelectedTime = cubit.time;
        cubit.tempSelectedTimeRoundTrip = cubit.timeRoundTrip;
      },);
      buttonController = GroupButtonController(selectedIndex: cubit.tempAddDateTimePageIndex);
    }
    return BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: cubit.tempAddDateTimePageIndex == 1 ? LocaleKeys.kDepartureTime.tr() : LocaleKeys.kDepartureDate.tr()),
          Container(
            margin: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeData.s16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: SizeData.s8),
                          decoration: BoxDecoration(
                              color: ColorData.whiteColor200,
                              borderRadius: BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1
                          ),
                          padding: EdgeInsets.all(SizeData.s16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorData.primaryColor50,
                                    borderRadius: BorderRadius.circular(SizeData.s8)
                                ),
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: GroupButtonCustom(
                                  buttons: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kDate.tr(),
                                            style: cubit.tempAddDateTimePageIndex != 0 ? StyleData.textStyleGray400R12 : StyleData.textStyleWhite200R12,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          Assets.bookTaxiCalendarIcon,
                                          width: Unit(context).iconSize(SizeData.s16),
                                          height: Unit(context).iconSize(SizeData.s16),
                                          color: cubit.tempAddDateTimePageIndex != 0 ? ColorData.grayColor400 : ColorData.whiteColor200,
                                          fit: BoxFit.scaleDown,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kTime.tr(),
                                            style: cubit.tempAddDateTimePageIndex == 0 ? StyleData.textStyleGray400R12 : StyleData.textStyleWhite200R12,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          Assets.bookTaxiClockIcon,
                                          width: Unit(context).iconSize(SizeData.s16),
                                          height: Unit(context).iconSize(SizeData.s16),
                                          color: cubit.tempAddDateTimePageIndex == 0 ? ColorData.grayColor400 : ColorData.whiteColor200,
                                          fit: BoxFit.scaleDown,
                                        )
                                      ],
                                    )
                                  ],
                                  options: GroupButtonOptions(
                                    borderRadius: BorderRadius.circular(SizeData.s8),
                                    groupingType: GroupingType.row,
                                    mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                                    selectedColor: ColorData.primaryColor400,
                                    unselectedTextStyle: StyleData.textStyleGray400R12,
                                    selectedTextStyle: StyleData.textStyleWhite200R12,
                                    buttonWidth: Unit(context).width(SizeData.s125),
                                    unselectedColor: ColorData.primaryColor50,
                                    spacing: 0,
                                    runSpacing: 0,
                                    selectedShadow: [],
                                    unselectedShadow: [],
                                  ),
                                  controller: buttonController,
                                  onSelected: (value, index, isSelected) {
                                    cubit.updateStateLessPageVar(change: () {
                                      cubit.tempAddDateTimePageIndex = index;
                                    },);
                                  },
                                ),
                              ),
                              if(cubit.tempAddDateTimePageIndex == 0)TableCalendar(
                                focusedDay: firstTrip ? cubit.tempFocusedDate : cubit.tempFocusedDateRoundTrip,
                                firstDay: DateTime.now(),
                                currentDay: DateTime.now(),
                                lastDay: DateTime(DateTime.now().year + 1),
                                calendarStyle: CalendarStyle(
                                  outsideDaysVisible: false,
                                  disabledTextStyle: StyleData.textStyleGray400R16,
                                  defaultTextStyle: StyleData.textStyleGray700R16,
                                  outsideTextStyle: StyleData.textStyleGray700R16,
                                  todayTextStyle: StyleData.textStyleBlue400R16,
                                  holidayTextStyle: StyleData.textStyleGray700R16,
                                  rangeEndTextStyle: StyleData.textStyleGray700R16,
                                  rangeStartTextStyle: StyleData.textStyleGray700R16,
                                  weekendTextStyle: StyleData.textStyleGray700R16,
                                  weekNumberTextStyle: StyleData.textStyleGray700R16,
                                  selectedTextStyle: StyleData.textStyleWhite200R16,
                                  withinRangeTextStyle: StyleData.textStyleGray700R16,
                                  defaultDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  disabledDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  holidayDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  markerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  outsideDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  weekendDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  rangeEndDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  rangeStartDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  rowDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  withinRangeDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  selectedDecoration: BoxDecoration(
                                      color: ColorData.blueColor400,
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                      shape: BoxShape.rectangle
                                  ),
                                  todayDecoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorData.blueColor400,
                                        width: Unit(context).width(SizeData.s1)
                                      ),
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                    shape: BoxShape.rectangle
                                  )
                                ),
                                weekNumbersVisible: false,
                                pageJumpingEnabled: true,
                                selectedDayPredicate: (day) =>isSameDay(day, firstTrip ? cubit.tempSelectedDate : cubit.tempSelectedDateRoundTrip),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: StyleData.textStyleGray700M14,
                                  weekendStyle: StyleData.textStyleGray700M14,
                                ),
                                daysOfWeekHeight: Unit(context).height(SizeData.s48),
                                calendarFormat: CalendarFormat.month,
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleTextStyle: StyleData.textStyleGray400R16,
                                  rightChevronIcon: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          pageController.previousPage(duration: const Duration(microseconds: 300), curve: Curves.bounceOut);
                                        },
                                        child: SizedBox(
                                          width: Unit(context).iconSize(SizeData.s38),
                                          height: Unit(context).iconSize(SizeData.s38),
                                          child: Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_left_rounded,
                                              size: Unit(context).iconSize(SizeData.s16),
                                              color: ColorData.grayColor600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          pageController.nextPage(duration: const Duration(microseconds: 300), curve: Curves.bounceIn);
                                        },
                                        child: SizedBox(
                                          width: Unit(context).iconSize(SizeData.s38),
                                          height: Unit(context).iconSize(SizeData.s38),
                                          child: Center(
                                            child: Icon(
                                                Icons.keyboard_arrow_right_rounded,
                                              size: Unit(context).iconSize(SizeData.s16),
                                              color: ColorData.grayColor600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  leftChevronVisible: false,
                                ),
                                rowHeight: Unit(context).height(SizeData.s48),
                                onCalendarCreated: (pageController) {
                                  this.pageController = pageController;
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  cubit.updateStateLessPageVar(change: () {
                                    if (firstTrip) {
                                      cubit.tempSelectedDate = selectedDay;
                                      cubit.tempFocusedDate = focusedDay;
                                    } else {
                                      cubit.tempSelectedDateRoundTrip = selectedDay;
                                      cubit.tempFocusedDateRoundTrip = focusedDay;
                                    }
                                  },);
                                },
                              ),
                              if(cubit.tempAddDateTimePageIndex != 0)MediaQuery(
                                data: const MediaQueryData().copyWith(alwaysUse24HourFormat: true),
                                child: TimePickerDialogCustom(
                                  initialTime: firstTrip ? cubit.tempSelectedTime : cubit.tempSelectedTimeRoundTrip,
                                  onSubmit: (TimeOfDay selected) {
                                    cubit.updateStateLessPageVar(change: () {
                                      if (firstTrip) {
                                        cubit.tempSelectedTime = selected;
                                      } else {
                                        cubit.tempSelectedTimeRoundTrip = selected;
                                      }
                                    },);
                                  },
                                  onOk: (TimeOfDay selected) {
                                    cubit.updateStateLessPageVar(change: () {
                                      if (firstTrip) {
                                        cubit.tempSelectedTime = selected;
                                      } else {
                                        cubit.tempSelectedTimeRoundTrip = selected;
                                      }
                                    },);
                                    if(firstTrip) {
                                      cubit.changeDate(value: cubit.tempSelectedDate);
                                      cubit.changeTime(value: cubit.tempSelectedTime);
                                    } else {
                                      cubit.changeDateRoundTrip(value: cubit.tempSelectedDateRoundTrip);
                                      cubit.changeTimeRoundTrip(value: cubit.tempSelectedTimeRoundTrip);
                                    }
                                    cubit.updateStateLessPageVar(change: () {
                                      if (firstTrip) {
                                        cubit.dateTimeSelected = true;
                                      } else {
                                        cubit.dateTimeSelectedRoundTrip = true;
                                      }
                                    },);
                                  },
                                )/*TimePickerDialog(initialTime: firstTrip ? cubit.tempSelectedTime : cubit.tempSelectedTimeRoundTrip)*/,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: MainButtonCustom(
                    onTap: () {
                      if(firstTrip) {
                        cubit.changeDate(value: cubit.tempSelectedDate);
                        cubit.changeTime(value: cubit.tempSelectedTime);
                      } else {
                        cubit.changeDateRoundTrip(value: cubit.tempSelectedDateRoundTrip);
                        cubit.changeTimeRoundTrip(value: cubit.tempSelectedTimeRoundTrip);
                      }
                      cubit.updateStateLessPageVar(change: () {
                        if (firstTrip) {
                          cubit.dateTimeSelected = true;
                        } else {
                          cubit.dateTimeSelectedRoundTrip = true;
                        }
                      },);
                      context.pop();
                    },
                    text: LocaleKeys.kSubmit.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
                  ),
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
