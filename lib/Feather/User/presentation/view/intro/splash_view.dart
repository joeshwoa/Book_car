import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/view/widget/intro_top_bar_custom.dart';
import 'package:public_app/generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3), (){
          if(SharedPreferencesServices.getData(key: ConstantData.kShowOnBoarding)??false){
            BlocProvider.of<UserCubit>(context).checkIsLogin();
            context.go(AppRouter.kLayoutView);
          }else{
            context.go(AppRouter.kOnBoardingView);
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      body: Container(
        height: Unit(context).getHeightSize,
        width: Unit(context).getWidthSize,
        decoration: ConstantData.decorationIntro,
        child: Padding(
          padding: EdgeInsets.only(top: SizeData.s40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SafeArea(child: IntroTopBarCustom()),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeData.s15),
                      child: SvgPicture.asset(Assets.userLogoLowOpacity,
                        width: Unit(context).getWidthSize,

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.userVanIntro,
                          width: Unit(context).getWidthSize*0.64,
                        )
                      ],
                    ).animate().moveX(delay: 500.ms, duration: 900.ms, begin: -Unit(context).getWidthSize*0.64, end: 0)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
