import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/view/widget/intro_top_bar_custom.dart';
import 'package:public_app/generated/assets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  PageController pageViewController = PageController(initialPage: 0);

  int get pageViewCurrentIndex => pageViewController.hasClients &&
      pageViewController.page != null
      ? pageViewController.page!.round()
      : 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Unit(context).getHeightSize,
        width: Unit(context).getWidthSize,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorData.gradientColor1,
              ColorData.gradientColor2,
              ColorData.gradientColor3,
              ColorData.gradientColor4,
              ColorData.gradientColor5,
              ColorData.gradientColor6,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: SizeData.s44),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IntroTopBarCustom(),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeData.s24, vertical: SizeData.s8),
                    child: GestureDetector(
                      onTap: () async {
                        if (pageViewCurrentIndex != 2) {
                          pageViewController.jumpToPage(2);
                          setState(() {});
                        }
                      },
                      child: Text(
                        pageViewCurrentIndex != 2?LocaleKeys.kSkip.tr():'',
                        style: StyleData.textStylePrimary100R14,
                      ),
                    ),
                  )
                ],
              ),*/
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if(pageViewCurrentIndex != 2)Padding(
                      padding: EdgeInsets.all(SizeData.s17),
                      child: SvgPicture.asset(
                        Assets.userLogoLowOpacity,
                        width: Unit(context).getWidthSize,

                      ),
                    ),
                    PageView(
                      controller: pageViewController,
                      scrollDirection: Axis.horizontal,
                      allowImplicitScrolling: true,
                      children: [
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.userCarIntro,
                              width: Unit(context).getWidthSize*0.63,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.userOnboardingPage3,
                              width: Unit(context).getWidthSize*0.64,
                            )
                          ],
                        ),
                      ],
                      onPageChanged: (int page) async {
                        await pageViewController.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      },
                    ),
                    if(pageViewCurrentIndex != 2)Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: SmoothPageIndicator(
                        controller: pageViewController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) async {
                          await pageViewController.animateToPage(
                            i,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                          setState(() {});
                        },
                        effect: CustomizableEffect(
                          spacing: 8,
                          dotDecoration: DotDecoration(
                            borderRadius: BorderRadius.circular(SizeData.s6),
                            color: ColorData.primaryColor200,
                            height: SizeData.s8,
                            width: SizeData.s8,
                          ),
                          activeDotDecoration: DotDecoration(
                            borderRadius: BorderRadius.circular(SizeData.s6),
                            color: ColorData.whiteColor200,
                            height: SizeData.s8,
                            width: SizeData.s8,
                          ),
                        ),
                      ),
                    ),
                    if(pageViewCurrentIndex == 2)Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: SizedBox(
                        width: Unit(context).getWidthSize*0.64,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.kBookYourVTCTAXICABMinibusAndBus.tr(),
                              style: StyleData.textStyleNatural0M18,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SizeData.s8),
                              child: Text(
                                LocaleKeys.kNoMatterHowManyPeopleAreYouTravelingWithWeHaveAVehicleThatSuitsYourNeeds.tr(),
                                style: StyleData.textStyleNatural100R12,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: SizeData.s40, top: SizeData.s140),
                child: GestureDetector(
                  onTap: () {
                    SharedPreferencesServices.setData(key: ConstantData.kShowOnBoarding, value: true);
                    context.push(AppRouter.kLayoutView, extra: true);
                  },
                  child: Container(
                    width: SizeData.s211,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeData.s8),
                        color: ColorData.whiteColor200
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(SizeData.s12),
                        child: Text(
                          LocaleKeys.kGetStarted.tr(),
                          style: StyleData.textStylePrimary700M16,
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
    );
  }
}
