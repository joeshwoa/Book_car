import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/enter_phone_sheet_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/success_dialog.dart';


buildChangePasswordSheet({required BuildContext context}){

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode oldPasswordNode = FocusNode();
  FocusNode newPasswordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeData.s20),
            topRight: Radius.circular(SizeData.s20),
          )
      ),
      builder: (context) {
        return BlocConsumer<UserCubit,UserState>(
            builder: (context,state){
              var cubit = UserCubit.get(context);
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: SizeData.s20,
                      left: SizeData.s20,
                      right: SizeData.s20,
                      bottom: MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: Form(
                    key: kForm,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(),
                            ),
                            Text(LocaleKeys.kChangePassword.tr(),
                              style: StyleData.textStyle14.copyWith(
                                fontSize: Unit(context).getWidthSize*0.037,
                                color: ColorData.grayColor600
                              ),
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
                                    color: ColorData.grayColor600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeData.s10,),
                        Center(
                          child: Text(LocaleKeys.kPleaseEnterYourOldPasswordToChangePassword.tr(),
                            style: StyleData.textStyle14Regular.copyWith(
                              color: ColorData.grayColor400,
                              fontSize: Unit(context).getWidthSize*0.037
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: SizeData.s15,),

                        InputTextCustom(
                          controller: oldPasswordController,
                          hintText: LocaleKeys.kEnterOldPassword.tr(),
                          focusNode: oldPasswordNode,
                          textInputType: TextInputType.visiblePassword,
                          onEditingComplete: ()=>FocusScope.of(context).requestFocus(newPasswordNode),
                        ),
                        SizedBox(height: SizeData.s10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                buildEnterPhoneSheet(context: context);
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

                        InputTextCustom(
                          controller: newPasswordController,
                          hintText: LocaleKeys.kEnterNewPassword.tr(),
                          focusNode: newPasswordNode,
                          textInputType: TextInputType.visiblePassword,
                          onEditingComplete: ()=>FocusScope.of(context).requestFocus(confirmPasswordNode),
                          obscureText: cubit.showPasswordLogin,
                          suffixIcon: cubit.showPasswordLogin?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                          onPressSuffixIcon: cubit.changeShowPasswordLogin,
                          validator: (val){
                            if(val!.isEmpty || val.length<=7){
                              return '';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: SizeData.s15,),

                        InputTextCustom(
                          controller: confirmPasswordController,
                          hintText: LocaleKeys.kConfirmNewPassword.tr(),
                          focusNode: confirmPasswordNode,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: cubit.showConfirmPassword,
                          suffixIcon: cubit.showConfirmPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                          onPressSuffixIcon: cubit.changeShowConfirmPassword,
                          validator: (val){
                            if(val!.isEmpty || val.length<=7){
                              return '';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: SizeData.s20,),
                        (state is LoadingChangePasswordState)?
                        const LoadingAppCustom():
                        MainButtonCustom(
                            onTap: (){
                          if(kForm.currentState!.validate()){
                            if(newPasswordController.text == confirmPasswordController.text){
                              cubit.changePassword(
                                newPassword: newPasswordController.text,
                                oldPassword: oldPasswordController.text
                              );
                            }else{
                              showErrorToast(context: context,msg: LocaleKeys.kPasswordIsNotTheSame.tr());
                            }

                          }
                        },
                            text: LocaleKeys.kSave.tr(),
                          textStyle: StyleData.textStyle14.copyWith(
                              color: ColorData.whiteColor200,
                              fontSize: Unit(context).getWidthSize*0.042
                          ),
                          color: ColorData.primaryColor1000,
                        ),
                        SizedBox(height: SizeData.s20,),

                      ],
                    )
                  ));
            },
            listener: (context,state){
              if(state is SuccessChangePasswordState){
                Navigator.pop(context);
                showDialog(context: context,
                    barrierDismissible: false,
                    builder: (context){
                      return buildSuccessDialog(context: context,msg: LocaleKeys.kYourPasswordHasBeenChangedSuccessfully.tr());
                    });
              }else if(state is ErrorChangePasswordState){
                showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
              }else if(state is FailChangePasswordState){
                showErrorToast(context: context,msg: state.msg??'');
              }
            });
      });
}

