import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';
import 'package:intl_phone_field/countries.dart';

class InputEnableProfileCustom extends StatelessWidget {
  final bool isEnable;
  final Function() fct;
  final Function() doneFct;
  final Function() closeFct;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String image;
  final bool phoneField;
  final void Function(Country val)? changeCodeFct;
  final String? initialCountryCode;
  InputEnableProfileCustom({super.key, required this.isEnable, required this.fct, required this.controller, required this.focusNode, required this.hintText, required this.image, required this.doneFct, required this.closeFct, this.phoneField = false, this.changeCodeFct, this.initialCountryCode});

  bool first = true;
  String code = '';
  @override
  Widget build(BuildContext context) {
    if(first) {
      first = false;
      if(phoneField) {
        code = controller.text.split(' ')[0];
      }
    }
    return phoneField && isEnable ? Stack(
      children: [
        IntlPhoneField(
          focusNode: focusNode,
          textInputAction:TextInputAction.next,
          initialCountryCode: initialCountryCode,
          disableLengthCheck: true,
          keyboardType: TextInputType.phone,
          controller: controller,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Color(0XFF090A0A),
              fontWeight: FontWeight.w400,
              fontSize: 16
          ),
          onCountryChanged: (value) {
            String oldNumber = controller.text.split(' ')[1];

            controller.text = '${value.code} $oldNumber';
            code = value.code;
          },onChanged: (value) {
            if(controller.text.length < '+$code '.length) {
              controller.text =  '+$code ';
            }
            if (!controller.text.contains('+$code ')) {
              String number = controller.text;

              controller.text = '+$code $number';
            }
            if (controller.text.allMatches('+$code ').length>1) {
              controller.text.replaceAll('+$code ', '');
              String number = controller.text;
              controller.text = '+$code $number';
            }
            if (!controller.text.startsWith('+$code ')) {
              String number = controller.text.split('+$code ')[1];
              controller.text = '+$code $number';
            }
          },
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.grayColor200,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.grayColor200,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.blueColor400,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.dangerColor400,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.dangerColor400,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                  top: 15,right: 15,bottom: 15),
              child: SvgPicture.asset(image,
                color: isEnable ? ColorData.blueColor300 : ColorData.primaryColor200,
              ),
            ),
            suffixIcon: isEnable ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeData.s8),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.done_rounded,
                      size: SizeData.s24,
                      color: ColorData.whiteColor200,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: SizeData.s24,
                    color: ColorData.whiteColor200,
                  ),
                )
              ],
            ) : Container(
              padding: EdgeInsets.only(left: SizeData.s16),
              child: SvgPicture.asset(
                Assets.userEditIcon,
                width: SizeData.s24,
                height: SizeData.s24,
                fit: BoxFit.scaleDown,
                color: ColorData.whiteColor200,
              ),
            ),
            hintText: hintText,
            hintStyle: StyleData.textStyleGray500R12.copyWith(
                color: ColorData.grayColor500,
                fontSize: Unit(context).getWidthSize*0.032
            ),
            enabled: isEnable,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: isEnable ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: SizeData.s8),
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: doneFct,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.done_rounded,
                      size: SizeData.s24,
                      color: ColorData.grayColor600,
                    ),
                  ),
                ),
              ),
              InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: closeFct,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: SizeData.s24,
                    color: ColorData.dangerColor500,
                  ),
                ),
              )
            ],
          ) : InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: fct,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                Assets.userEditIcon,
                width: SizeData.s24,
                height: SizeData.s24,
                color: ColorData.primaryColor200,
              ),
            ),
          ),
        ),
      ],
    ) : Stack(
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.grayColor200,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.grayColor200,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.blueColor400,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.dangerColor400,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorData.dangerColor400,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                  top: 15,right: 15,bottom: 15),
              child: SvgPicture.asset(image,
                color: isEnable ? ColorData.blueColor300 : ColorData.primaryColor200,
              ),
            ),
            suffixIcon: isEnable ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeData.s8),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.done_rounded,
                      size: SizeData.s24,
                      color: ColorData.whiteColor200,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: SizeData.s24,
                    color: ColorData.whiteColor200,
                  ),
                )
              ],
            ) : Container(
              padding: EdgeInsets.only(left: SizeData.s16),
              child: SvgPicture.asset(
                Assets.userEditIcon,
                width: SizeData.s24,
                height: SizeData.s24,
                fit: BoxFit.scaleDown,
                color: ColorData.whiteColor200,
              ),
            ),
            hintText: hintText,
            hintStyle: StyleData.textStyleGray500R12.copyWith(
                color: ColorData.grayColor500,
                fontSize: Unit(context).getWidthSize*0.032
            ),
            enabled: isEnable,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.kPleaseFillThisField.tr();
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          obscureText: false,
          keyboardType: TextInputType.name,
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: isEnable ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: SizeData.s8),
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: doneFct,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.done_rounded,
                      size: SizeData.s24,
                      color: ColorData.grayColor600,
                    ),
                  ),
                ),
              ),
              InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: closeFct,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: SizeData.s24,
                    color: ColorData.dangerColor500,
                  ),
                ),
              )
            ],
          ) : InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: fct,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                Assets.userEditIcon,
                width: SizeData.s24,
                height: SizeData.s24,
                color: ColorData.primaryColor200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
