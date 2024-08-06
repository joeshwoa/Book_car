import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/helper/cache_image.dart';
import 'package:public_app/Core/services/launch_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/contact_box_custom.dart';
import 'package:public_app/generated/assets.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {

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
              AppBarCustom(title: LocaleKeys.kHelp.tr()),
              Container(
                margin : EdgeInsets.only(top: Unit(context).getHeightSize*0.15,
                  left: SizeData.s15,
                  right: SizeData.s15,),
                decoration: BoxDecoration(
                    color: ColorData.whiteColor200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeData.s20),
                      topRight: Radius.circular(SizeData.s20),
                    )
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(SizeData.s20),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeData.s10),
                        decoration: ConstantData.decorationUser,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.kContactUs.tr(),
                              style: StyleData.textStyle14.copyWith(
                                  fontSize: Unit(context).getWidthSize*0.037,
                                  color: ColorData.grayColor700
                              ),
                            ),
                            ContactBoxCustom(
                              text: ConstantData.phoneNumberKiro,
                              image: Assets.userPhoneIcon,
                              fct: ()async{
                                await launchLink(
                                    Uri(
                                      scheme: 'tel',
                                      path: ConstantData.phoneNumberKiro.replaceAll(" ", ""),
                                    )
                                );
                              },
                            ),

                            ContactBoxCustom(
                              text: ConstantData.callUsKiro,
                              image: Assets.userWhatsappIcon,
                              fct: ()async{
                                final url = 'https://wa.me/${ConstantData.phoneNumberKiro.replaceAll(" ", "")}';
                                await launchLink(Uri.parse(url),);
                              },
                            ),

                            ContactBoxCustom(
                              text: ConstantData.mailKiro,
                              image:Assets.userSms,
                              fct: ()async{
                                await launchLink(Uri(
                                    scheme: 'mailto',
                                    path: ConstantData.mailKiro,
                                    queryParameters: {'subject': '', 'body': ''}));
                              },
                            ),

                            SizedBox(height: SizeData.s10),

                            GestureDetector(
                              onTap: () {
                                context.pop();
                                cubit.changeCurrentIndexLayout(1);
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeData.s10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeData.s8),
                                  color: ColorData.primaryColor1000,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(LocaleKeys.kChatWithUs.tr(),
                                        style: StyleData.textStyle14.copyWith(
                                            fontSize: Unit(context).getWidthSize*0.042,
                                            color: ColorData.whiteColor200
                                        ),
                                      ),
                                      SizedBox(width: SizeData.s10,),
                                      SvgPicture.asset(
                                        Assets.userChatWithUsIcon,
                                        height: Unit(context).getWidthSize*0.064,
                                        width: Unit(context).getWidthSize*0.064,
                                        color: ColorData.primaryColor50,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeData.s20,),

                      GestureDetector(
                        onTap: (){
                          GoRouter.of(context).push(AppRouter.kHelpCenterView);
                        },
                        child: Container(
                          padding: EdgeInsets.all(SizeData.s15),
                          decoration: ConstantData.decorationUser,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(LocaleKeys.kHelpCenter.tr(),
                                  style: StyleData.textStyle14Regular.copyWith(
                                      fontSize: Unit(context).getWidthSize*0.037,
                                      color: ColorData.grayColor600
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                Assets.userHelpIcon,
                                height: Unit(context).getWidthSize*0.064,
                                width: Unit(context).getWidthSize*0.064,
                                color: ColorData.primaryColor600,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: SizeData.s20,),


                      Container(
                        padding: EdgeInsets.all(SizeData.s15),
                        width: double.infinity,
                        decoration: ConstantData.decorationUser,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.kFollowUs.tr(),
                              style: StyleData.textStyle14.copyWith(
                                  fontSize: Unit(context).getWidthSize*0.037,
                                  color: ColorData.grayColor700
                              ),
                            ),
                            SizedBox(height: SizeData.s10,),

                            ...cubit.listSocial.map((e){
                              return contactUs(context: context,title: e.title??'',image: e.icon??'',link: e.link??'');
                            })

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget contactUs({required String image , required String title , required BuildContext context,required String link}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
      child: GestureDetector(
        onTap: (){
          launchLink(Uri.parse(link));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CacheImageCustom(
                image: image,
                height: Unit(context).getWidthSize*0.064,
                width: Unit(context).getWidthSize*0.064,
              ),
            ),
            SizedBox(width: SizeData.s15,),
            Expanded(
              child: Text(title,
                  style: StyleData.textStyle14Regular.copyWith(
                      fontSize: Unit(context).getWidthSize*0.037,
                      color: ColorData.grayColor600
                  )
              ),
            ),
            SvgPicture.asset(
              Assets.userArrowRightIcon,
              height: SizeData.s20,
              width: SizeData.s20,
              color: ColorData.grayColor600,
            ),
          ],
        ),
      ),
    );
  }
}
