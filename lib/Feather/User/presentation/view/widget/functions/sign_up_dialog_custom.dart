import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_phone_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/generated/assets.dart';

class SignUpDialogCustom extends StatefulWidget {
  const SignUpDialogCustom({super.key});

  @override
  State<SignUpDialogCustom> createState() => _SignUpDialogCustomState();
}

class _SignUpDialogCustomState extends State<SignUpDialogCustom> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  FocusNode fullNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  String starsPhoneNumber = '*********';


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      elevation: 0.0,
      contentPadding: EdgeInsets.all(SizeData.s20),
      insetPadding: EdgeInsets.all(SizeData.s20),
      content: Form(
        key: kForm,
        child: BlocConsumer<UserCubit,UserState>(
          builder: (context,state){
            var cubit = UserCubit.get(context);
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: Unit(context).getWidthSize*0.8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        LocaleKeys.kSignUp.tr(),
                        style: StyleData.textStyleGray700M14,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                  SizedBox(height: SizeData.s20,),
                  Center(
                    child: Text(LocaleKeys.kHereYouCanCreateNewAccount.tr(),
                      style: StyleData.textStyleGray400R12,
                    ),
                  ),
                  SizedBox(height: SizeData.s10,),

                  InputTextCustom(
                    controller: fullNameController,
                    hintText: LocaleKeys.kFullName.tr(),
                    focusNode: fullNameNode,
                    textInputType: TextInputType.name,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(emailNode),
                    prefix: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        Assets.userUserNameIcon,
                        color: ColorData.primaryColor200,
                      ),
                    ),
                    onChanged: (p0) => setState(() {}),
                  ),
                  SizedBox(height: SizeData.s10,),

                  InputTextCustom(
                    controller: emailController,
                    hintText: LocaleKeys.kEmail.tr(),
                    focusNode: emailNode,
                    textInputType: TextInputType.emailAddress,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(phoneNode),
                    prefix: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        Assets.userSms,
                        color: ColorData.primaryColor200,
                      ),
                    ),
                    onChanged: (p0) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.kPleaseFillThisField.tr();
                      }
                      if (!RegExp(r'^[^\d][\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                        return LocaleKeys.kPleaseEnterAValidEmail.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeData.s10,),

                  InputPhoneCustom(
                    controller: phoneController,
                    labelText: '+${cubit.valCodeCountry} $starsPhoneNumber',
                    focusNode: phoneNode,
                    onCountryChanged: (val){
                      cubit.changeValCodeCountry(val.dialCode);
                      starsPhoneNumber = '';
                      for(int i = 0; i < val.maxLength; i++) {
                        starsPhoneNumber += '*';
                      }
                    },
                  ),
                  SizedBox(height: SizeData.s10,),

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
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(confirmPasswordNode),
                    obscureText: cubit.showPasswordLogin,
                    suffixIcon: cubit.showPasswordLogin?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                    onPressSuffixIcon: cubit.changeShowPasswordLogin,
                    validator: (val){
                      if(val!.isEmpty || val.length<=7){
                        return LocaleKeys.kPasswordsMustBeAtLeast8Characters.tr();
                      }
                      return null;
                    },
                    onChanged: (p0) => setState(() {}),
                  ),

                  SizedBox(height: SizeData.s10,),

                  InputTextCustom(
                    controller: confirmPasswordController,
                    hintText: LocaleKeys.kConfirmNewPassword.tr(),
                    focusNode: confirmPasswordNode,
                    prefix: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        Assets.userUnlock,
                        color: ColorData.primaryColor200,
                      ),
                    ),
                    obscureText: cubit.showConfirmPassword,
                    suffixIcon: cubit.showConfirmPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                    onPressSuffixIcon: cubit.changeShowConfirmPassword,
                    validator: (val){
                      if(val!.isEmpty || val.length<=7){
                        return LocaleKeys.kPasswordsMustBeAtLeast8Characters.tr();
                      }
                      return null;
                    },
                    onChanged: (p0) => setState(() {}),
                  ),
                  SizedBox(height: SizeData.s20,),

                  (state is LoadingSignUpState)?
                  const LoadingAppCustom():
                  MainButtonCustom(onTap: (){
                    if(kForm.currentState!.validate()){
                      if(phoneController.text.isNotEmpty){
                        if(passwordController.text == confirmPasswordController.text){
                          cubit.signUp(
                            email: emailController.text,
                            name: fullNameController.text,
                            phone: phoneController.text,
                            password:passwordController.text
                          );
                        }else{
                          showErrorToast(context: context,msg: LocaleKeys.kPasswordIsNotTheSame.tr());
                        }
                      }else{
                        showErrorToast(context: context,msg: LocaleKeys.kPleaseEnterYourNewPhoneNumber.tr());
                      }

                    }
                  },text: LocaleKeys.kSignUp.tr(),
                    textStyle: emailController.text.isNotEmpty && fullNameController.text.isNotEmpty && phoneController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty? StyleData.textStyle14.copyWith(
                        color: ColorData.whiteColor200,
                        fontSize: Unit(context).getWidthSize*0.042
                    ) : StyleData.textStyleGray400M16,
                    color: emailController.text.isNotEmpty && fullNameController.text.isNotEmpty && phoneController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty? ColorData.primaryColor1000 : ColorData.grayColor300,)

                ],
              ),
            );
          },
          listener: (context,state){
            if(state is SuccessSignUpState){
              Navigator.pop(context);
            }else if(state is FailSignUpState){
              showErrorToast(context: context,msg: state.msg??'');
            }else if (state is ErrorSignUpState){
              showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
            }

          },
        ),
      ),
    );
  }

}