import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/forget_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class LogInToViewPriceDialogCustom extends StatefulWidget {

  final bool showRememberMeRow;
  const LogInToViewPriceDialogCustom({super.key, required this.showRememberMeRow});

  @override
  State<LogInToViewPriceDialogCustom> createState() => _LogInToViewPriceDialogCustomState();
}

class _LogInToViewPriceDialogCustomState extends State<LogInToViewPriceDialogCustom> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool visionPassword = false;
  bool shareData = false;
  bool rememberMe = false;

  bool valid = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            LocaleKeys.kLogIn.tr(),
            style: StyleData.textStyleGray700M14,
          ),
          Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: SizeData.s24,
                    color: ColorData.grayColor700,
                  ),
                ),
              )
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: BorderData.outlineInputBorderGray200W1R8,
                    enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                    focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                    errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                    focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(SizeData.s4),
                      child: SvgPicture.asset(
                        Assets.userMessageIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        color: ColorData.grayColor300,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: Unit(context).iconSize(SizeData.s32),
                      maxHeight: Unit(context).iconSize(SizeData.s32),
                    ),
                    errorStyle: const TextStyle(
                        fontSize: 0
                    ),
                    hintText: LocaleKeys.kEmail.tr(),
                    hintStyle: StyleData.textStyleGray500R12,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.kPleaseFillThisField.tr();
                    }
                    return null;
                  },
                  autofocus: false,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: BorderData.outlineInputBorderGray200W1R8,
                    enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                    focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                    errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                    focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            visionPassword = !visionPassword;
                          });
                        },
                        child: SvgPicture.asset(
                          Assets.userUnlock,
                          width: Unit(context).iconSize(SizeData.s24),
                          height: Unit(context).iconSize(SizeData.s24),
                          color: ColorData.grayColor300,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: SizeData.s24+8,
                      maxHeight: SizeData.s24+8,
                    ),
                    errorStyle: const TextStyle(
                        fontSize: 0
                    ),
                    hintText: LocaleKeys.kPassword.tr(),
                    hintStyle: StyleData.textStyleGray500R12,
                  ),
                  obscureText: !visionPassword,
                  enableSuggestions: visionPassword,
                  autocorrect: visionPassword,
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.kPleaseFillThisField.tr();
                    }
                    return null;
                  },
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              if(widget.showRememberMeRow)SizedBox(
                width: Unit(context).getWidthSize*0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          onChanged: (checked) {
                            setState(() {
                              rememberMe = checked!;
                            });
                          },
                          value: rememberMe,
                          activeColor: ColorData.primaryColor700,
                        ),
                        Text(
                          LocaleKeys.kRememberMe.tr(),
                          style: StyleData.textStyleGray600R12,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        showDialog(context: context, builder: (context) => ForgetDialogCustom(title: LocaleKeys.kForgetPassword.tr()));
                      },
                      child: Text(
                        LocaleKeys.kForgotPasswordQ.tr(),
                        style: StyleData.textStyleBlue400R12,
                      ),
                    )
                  ],
                ),
              ),
              if(!widget.showRememberMeRow)SizedBox(
                width: Unit(context).getWidthSize*0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      onChanged: (checked) {
                        setState(() {
                          shareData = checked!;
                        });
                      },
                      value: shareData,
                      activeColor: ColorData.primaryColor700,
                    ),
                    SizedBox(
                      width: Unit(context).getWidthSize*0.55,
                      child: Text(
                        LocaleKeys.kIConsentToSharingMyDataToCreateAnAccount.tr(),
                        style: StyleData.textStyleGray500R14,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              if(!valid)Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: SizedBox(
                  width: Unit(context).getWidthSize*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(SizeData.s4),
                        child: SvgPicture.asset(
                          Assets.bookTaxiWarningIcon,
                          width: Unit(context).iconSize(SizeData.s16),
                          height: Unit(context).iconSize(SizeData.s16),
                          color: ColorData.dangerColor300,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.kEnterAValidEmailAddressOrPassword.tr(),
                              style: StyleData.textStyleDanger300R12,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        MainButtonCustom(
          onTap: () {
            if(formKey.currentState!.validate()) {
              setState(() {
                valid = true;
              });
              context.pop();
              context.push(AppRouter.kViewPriceView);
            } else {
              setState(() {
                valid = false;
              });
            }

          },
          text: LocaleKeys.kLogIn.tr(),
          textStyle: emailController.text.isNotEmpty && passwordController.text.isNotEmpty ? StyleData.textStylePrimary50M16 : StyleData.textStyleGray400M16,
          color: emailController.text.isNotEmpty && passwordController.text.isNotEmpty ? ColorData.primaryColor1000 : ColorData.grayColor300,
        ),
      ],
    );
  }
}