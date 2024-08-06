import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/error_msg_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_phone_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/check_email_dialog.dart';


buildEnterPhoneSheet({required BuildContext context}){

  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode =FocusNode();

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: ColorData.whiteColor200,
      elevation: 0.0,
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
                padding: EdgeInsets.only(
                    top: SizeData.s20,
                    left: SizeData.s20,
                    right: SizeData.s20,
                    bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        Text(
                            LocaleKeys.kForgetPassword.tr(),
                            style: StyleData.textStyle14.copyWith(
                                fontSize: Unit(context).getWidthSize*0.037,
                                color: ColorData.grayColor600
                            )
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
                    SizedBox(height: SizeData.s20,),
                    Text(LocaleKeys.kPleaseEnterYourNewPhoneNumber.tr(),
                      style: StyleData.textStyle14Regular.copyWith(
                          color: ColorData.grayColor400,
                          fontSize: Unit(context).getWidthSize*0.037
                      ),
                    ),
                    SizedBox(height: SizeData.s20,),

                    InputPhoneCustom(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      onCountryChanged: (val){
                        cubit.changeValCodeCountry(val.dialCode);
                      },
                    ),

                    SizedBox(height: SizeData.s15,),

                    (state is FailForgetMailState)?
                    ErrorMsgCustom(msg: LocaleKeys.kThisPhoneNumberDoesNotExits.tr(),):Container(),


                    SizedBox(height: SizeData.s20,),

                    (state is LoadingForgetMailState)?
                    const LoadingAppCustom():
                    MainButtonCustom(onTap: (){
                      cubit.resetPasswordLink(phone: phoneController.text);
                    }, text: LocaleKeys.kContinue.tr(),
                      textStyle: StyleData.textStyle14.copyWith(
                          color: ColorData.whiteColor200,
                          fontSize: Unit(context).getWidthSize*0.042
                      ),
                      color: ColorData.primaryColor1000,
                    ),

                    SizedBox(height: SizeData.s20,),
                  ],
                ),
              );
            },
            listener: (context,state){
              if(state is SuccessForgetMailState){
                Navigator.pop(context);
                showDialog(context: context,
                    barrierDismissible: false,
                    builder: (context){
                      return buildCheckEmailDialog(context: context, email: state.msg??'');
                    });
              }else if(state is ErrorForgetMailState){
                showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
              }
            });
      });
}