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
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/log_out_dialog_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/card_profile_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/profile_auth_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/social_media_row_custom.dart';
import 'package:public_app/generated/assets.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({super.key,});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getSocial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return Stack(
            children: [
              AppBarCustom(title: LocaleKeys.kProfile.tr(),
                  fct: (){
                    BlocProvider.of<UserCubit>(context).changeCurrentIndexLayout(0);
                  },showBack: false,),

              SizedBox(height: SizeData.s20,),

              Padding(
                padding: EdgeInsets.only(
                  top: SizeData.s107,
                  left: SizeData.s16,
                  right: SizeData.s16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorData.whiteColor200,
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
                          /*padding: EdgeInsets.all(SizeData.s20),*/
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ProfileAuthCustom(),
                              SizedBox(height: SizeData.s20,),
                              Text(
                                LocaleKeys.kGeneral.tr(),
                                style: StyleData.textStyle12.copyWith(
                                    fontSize: Unit(context).getWidthSize*0.032
                                ),
                              ),
                              CardProfileCustom(
                                fct: cubit.isUserLogin?() {
                                  GoRouter.of(context).push(AppRouter.kPersonalDataView);
                                }:null,
                                image: Assets.userUserEdit,
                                text: LocaleKeys.kPersonalData.tr(),
                              ),
                              CardProfileCustom(
                                image: Assets.userGlobal,
                                text: LocaleKeys.kMyBookings.tr(),
                                fct: cubit.isUserLogin?(){
                                  cubit.changeCurrentIndexLayout(2);
                                }:null,
                              ),
                              CardProfileCustom(
                                fct: (){
                                  cubit.updateLung(lung: context.locale == const Locale('en')? 'fr':'en', context: context);
                                },
                                image: Assets.userGlobal,
                                text: LocaleKeys.kLanguage.tr(),
                              ),
                              CardProfileCustom(
                                fct: () {
                                  GoRouter.of(context).push(AppRouter.kHelpView);
                                },
                                image: Assets.userMessageQuestion,
                                text: LocaleKeys.kHelp.tr(),
                              ),

                              SizedBox(height: SizeData.s20,),

                              cubit.isUserLogin?
                              GestureDetector(
                                onTap: () {
                                  showDialog(context: context,
                                      barrierDismissible: false,
                                      builder: (context) =>buildLogoutDialog(context: context));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Assets.userLogout,
                                      height:Unit(context).getWidthSize*0.064,
                                      width: Unit(context).getWidthSize*0.064,
                                    ),
                                    SizedBox(width: SizeData.s15,),
                                    Expanded(
                                      child: Text(LocaleKeys.kLogOut.tr(),
                                        style: StyleData.textStyle14Regular.copyWith(
                                          fontSize: Unit(context).getWidthSize*0.037,
                                          color: ColorData.dangerColor500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ):Container(),

                              SizedBox(height: Unit(context).getHeightSize*0.1,),

                              const SocialMediaRowCustom(),
                              SizedBox(height: SizeData.s20,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
