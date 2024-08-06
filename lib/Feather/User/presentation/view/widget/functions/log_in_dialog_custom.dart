import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/error_msg_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/helper/sussess_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/sign_up_dialog_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/enter_phone_dialog.dart';
import 'package:public_app/generated/assets.dart';

class LogInDialogCustom extends StatefulWidget {
  const LogInDialogCustom({super.key});

  @override
  State<LogInDialogCustom> createState() => _LogInDialogCustomState();
}

class _LogInDialogCustomState extends State<LogInDialogCustom> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(SizeData.s20),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s16)
      ),
      content: Form(
        key: kForm,
        child: BlocConsumer<UserCubit,UserState>(
          builder: (context,state){
            var cubit = UserCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: Unit(context).getWidthSize*0.8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox()
                      ),
                      Text(LocaleKeys.kLogIn.tr(),
                        style: StyleData.textStyle14.copyWith(
                            fontSize: Unit(context).getWidthSize*0.037,
                            color: ColorData.grayColor700
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              size: Unit(context).getWidthSize*0.064,
                              color: ColorData.grayColor700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: emailController,
                    hintText: LocaleKeys.kEmail.tr(),
                    focusNode: emailNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(passwordNode),
                    prefix: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        Assets.userSms,
                        color: ColorData.primaryColor200,
                      ),
                    ),
                    onChanged: (p0) => setState(() {}),
                  ),
                  SizedBox(height: SizeData.s10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(context: context, builder: (context) => const EnterPhoneDialogCustom(isForgetMail: true,));
                        },
                        child: Text(LocaleKeys.kForgotMail.tr(),
                          style: StyleData.textStyle12Regular.copyWith(
                              fontSize: Unit(context).getWidthSize*0.032
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: passwordController,
                    hintText: LocaleKeys.kPassword.tr(),
                    focusNode: passwordNode,
                    prefix: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        Assets.userUnlock,
                        color: ColorData.primaryColor200,
                      ),
                    ),
                    obscureText: cubit.showPasswordLogin,
                    suffixIcon: cubit.showPasswordLogin?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                    onPressSuffixIcon: cubit.changeShowPasswordLogin,
                    onChanged: (p0) => setState(() {}),
                  ),
                  SizedBox(height: SizeData.s10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(context: context, builder: (context) => const EnterPhoneDialogCustom(isForgetMail: false,));
                        },
                        child: Text(LocaleKeys.kForgotPassword.tr(),
                          style: StyleData.textStyle12Regular.copyWith(
                              fontSize: Unit(context).getWidthSize*0.032
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: SizeData.s15,),

                  (state is FailLoginState)?
                  ErrorMsgCustom(
                    msg: LocaleKeys.kEnterAValidEmailAddressOrPassword.tr(),
                  ):Container(),

                  SizedBox(height: SizeData.s20,),

                  (state is LoadingLoginState)?
                  const LoadingAppCustom():
                  MainButtonCustom(onTap: (){
                    if(kForm.currentState!.validate()){
                      cubit.login(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                      text: LocaleKeys.kLogIn.tr(),
                    textStyle: emailController.text.isNotEmpty && passwordController.text.isNotEmpty ? StyleData.textStyle14.copyWith(
                        color: ColorData.whiteColor200,
                        fontSize: Unit(context).getWidthSize*0.042
                    ) : StyleData.textStyleGray400M16,
                    color: emailController.text.isNotEmpty && passwordController.text.isNotEmpty ? ColorData.primaryColor1000 : ColorData.grayColor300,
                  ),

                  SizedBox(height: SizeData.s15,),

                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        showDialog(context: context, barrierDismissible: false ,builder: (context) => const SignUpDialogCustom());
                      },
                      child: Text(
                        LocaleKeys.kNewAccount.tr(),
                        style: StyleData.textStyle14.copyWith(
                            fontSize: Unit(context).getWidthSize*0.037,
                            color: ColorData.primaryColor500
                        ),),
                    ),
                  )
                ],
              ),
            );
          },
          listener: (context,state){
              if(state is SuccessLoginState){
                Navigator.pop(context);
                showSuccessToast(context: context,msg: state.msg??'');
              }else if(state is ErrorLoginState){
                Navigator.pop(context);
                showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
              }

          },
        ),
      ),
    );
  }
}