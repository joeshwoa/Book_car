import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';

class InputPhoneCustom extends StatelessWidget {
  final TextEditingController controller;
  String ? labelText;
  FocusNode? focusNode;
  Function(String)? onSubmitted;
  void Function(Country)? onCountryChanged;
  InputPhoneCustom({Key? key, required this.controller,this.focusNode,this.labelText,this.onSubmitted ,this.onCountryChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      focusNode: focusNode,
      textInputAction:TextInputAction.next,
      initialCountryCode: 'FR',
      disableLengthCheck: true,
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.phone,
      controller: controller,
      textAlign: TextAlign.start,
      style: const TextStyle(
          color: Color(0XFF090A0A),
          fontWeight: FontWeight.w400,
          fontSize: 16
      ),
      onCountryChanged: onCountryChanged,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: StyleData.textStyleGray400M12.copyWith(
            fontSize: Unit(context).getWidthSize*0.037,
            color: ColorData.grayColor400
        ),
        filled: true,
        fillColor: ColorData.whiteColor200,
        contentPadding: EdgeInsets.all(SizeData.s15),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorData.grayColor200,
          ),
          borderRadius: BorderRadius.circular(SizeData.s8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorData.grayColor200,),
          borderRadius: BorderRadius.circular(SizeData.s8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorData.primaryColor700,),
          borderRadius: BorderRadius.circular(SizeData.s8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorData.dangerColor400,),
          borderRadius: BorderRadius.circular(SizeData.s8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorData.dangerColor400,),
          borderRadius: BorderRadius.circular(SizeData.s8),
        ),
      ),
      /*validator: (val){
        if(val!.toString().isEmpty){
          return LocaleKeys.kFieldRequired.tr();
        }
      },*/
    );
  }
}
