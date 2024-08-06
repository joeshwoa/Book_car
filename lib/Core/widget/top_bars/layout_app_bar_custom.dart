import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/launch_services.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

enum IconOneType {
  logo,
  back,
  empty,
}

enum IconTwoType {
  call,
  empty,
}

class LayoutAppBarCustom extends StatelessWidget {

  final String title;
  final IconOneType iconOneType;
  final IconTwoType iconTwoType;
  const LayoutAppBarCustom({super.key, required this.title, this.iconOneType = IconOneType.back, this.iconTwoType = IconTwoType.empty});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeData.s147,
      decoration: BoxDecoration(
        color: ColorData.primaryColor500,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(SizeData.s16),
          bottomLeft: Radius.circular(SizeData.s16),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          SvgPicture.asset(
            Assets.userClipPathGroup,
            width: Unit(context).getWidthSize,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(SizeData.s8),
              child: Row(
                children: [
                  if(iconOneType == IconOneType.back)Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: SizeData.s24,
                            color: ColorData.primaryColor50,
                          ),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              context.pop();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  if(iconOneType == IconOneType.logo)Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: Unit(context).iconSize(SizeData.s48),
                        width: Unit(context).iconSize(SizeData.s48),
                        child: SvgPicture.asset(
                          Assets.imageLogo,
                          height: Unit(context).iconSize(SizeData.s48),
                          width: Unit(context).iconSize(SizeData.s48),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  if(iconOneType == IconOneType.empty)const Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    title,
                    style: StyleData.textStyleGray50M14,
                  ),
                  if(iconTwoType == IconTwoType.empty)const Expanded(
                    child: SizedBox(),
                  ),
                  if(iconTwoType == IconTwoType.call)Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          await launchLink(
                              Uri(
                                scheme: 'tel',
                                path: ConstantData.callUsKiro.replaceAll(" ", ""),
                              )
                          );
                        },
                        child: Container(
                          width: Unit(context).iconSize(SizeData.s40),
                          height: Unit(context).iconSize(SizeData.s40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SizeData.s8),
                            color: ColorData.whiteColor200.withOpacity(0.4)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(SizeData.s8),
                            child: SvgPicture.asset(
                              Assets.bookTaxiHalfPhoneIcon,
                              width: Unit(context).iconSize(SizeData.s24),
                              height: Unit(context).iconSize(SizeData.s24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
