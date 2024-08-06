
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/find_driver_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/my_bookings_view.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/chat_with_us_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/profile_view.dart';
import 'package:public_app/generated/assets.dart';

class LayoutView extends StatelessWidget {
  LayoutView({super.key});

  final List<Widget> _pages = [
    FindDriverView(firstTrip: true),
    const ChatWithUsView(),
    MyBookingsView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocBuilder<UserCubit,UserState>(
      builder: (context,state){
        var cubit = UserCubit.get(context);
        return Scaffold(
          body: _pages[cubit.currentIndexLayout],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndexLayout,
            unselectedItemColor: ColorData.grayColor400,
            selectedItemColor: ColorData.primaryColor500,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if(index == 2) {
                var cubit = MyBookingCubit.get(context);
                cubit.updateStateLessPageVar(change: () {
                  cubit.myBookingLoaded = false;
                });
                cubit.getMyBookings(changeTab: true);
              }
              cubit.changeCurrentIndexLayout(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.userHome, color: ColorData.grayColor400,),
                activeIcon: SvgPicture.asset(Assets.userHomeFilled, color: ColorData.primaryColor500,),
                label: LocaleKeys.kHome.tr(),
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.userChats, color: ColorData.grayColor400,),
                activeIcon: SvgPicture.asset(Assets.userChatsFilled, color: ColorData.primaryColor500,),
                label: LocaleKeys.kChat.tr(),
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.userBooking, color: ColorData.grayColor400,),
                activeIcon: SvgPicture.asset(Assets.userBookingFilled, color: ColorData.primaryColor500),
                label: LocaleKeys.kBookings.tr(),
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.userProfile, color: ColorData.grayColor400,),
                activeIcon: SvgPicture.asset(Assets.userProfileFilled, color: ColorData.primaryColor500),
                label: LocaleKeys.kProfile.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
