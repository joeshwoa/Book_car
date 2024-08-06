import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/services/launch_services.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  Function() ? fct;
  bool ? showCallButton;
  bool ? showLogo;
  bool ? showBack;
  AppBarCustom({super.key, required this.title , this.fct,this.showCallButton,this.showLogo,this.showBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeData.s10),
      height: Unit(context).getHeightSize*0.2,
      decoration: BoxDecoration(
        color: ColorData.primaryColor500,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(SizeData.s16),
          bottomLeft: Radius.circular(SizeData.s16),
        ),
      ),
      child: Stack(
        children: [
          SvgPicture.asset(
            Assets.userClipPathGroup,
            width: Unit(context).getWidthSize,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding:EdgeInsets.symmetric(vertical: SizeData.s10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (showLogo??false)?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(Assets.userLogo,
                      height: Unit(context).getWidthSize*0.128,
                      width: Unit(context).getWidthSize*0.128,),
                  ) :
                  (showBack??true)?SizedBox(
                    width: Unit(context).getWidthSize*0.15,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: Unit(context).getWidthSize*0.064,
                        color: ColorData.primaryColor50,
                      ),
                      onPressed: fct??() {
                        Navigator.of(context).pop();
                      },
                    ),
                  ): SizedBox(width: Unit(context).getWidthSize*0.15,),

                  Expanded(
                    child: Text(title,
                      style: StyleData.textStyle14.copyWith(
                          fontSize: Unit(context).getWidthSize*0.037,
                          color: ColorData.grayColor50
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  showCallButton??false?
                  InkWell(
                    onTap: ()async{
                      await launchLink(
                          Uri(
                            scheme: 'tel',
                            path: ConstantData.phoneNumberKiro.replaceAll(" ", ""),
                          )
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeData.s8),
                          color: ColorData.whiteColor200.withOpacity(0.4)
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Padding(
                        padding: EdgeInsets.all(SizeData.s8),
                        child: SvgPicture.asset(
                          Assets.bookTaxiHalfPhoneIcon,
                          width: Unit(context).getWidthSize*0.064,
                          height: Unit(context).getWidthSize*0.064,
                        ),
                      ),
                    ),
                  ):
                  SizedBox(width: Unit(context).getWidthSize*0.15,)

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
