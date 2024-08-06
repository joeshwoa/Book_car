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
import 'package:public_app/Feather/User/presentation/view/widget/functions/log_in_dialog_custom.dart';

class EnterPhoneDialogCustom extends StatefulWidget {
  final bool isForgetMail;
  const EnterPhoneDialogCustom({super.key, required this.isForgetMail});

  @override
  State<EnterPhoneDialogCustom> createState() => _EnterPhoneDialogCustomState();
}

class _EnterPhoneDialogCustomState extends State<EnterPhoneDialogCustom> {

  TextEditingController phoneController = TextEditingController();

  String starsPhoneNumber = '*********';
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).restartState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(SizeData.s20),
      insetPadding: EdgeInsets.all(SizeData.s20),
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeData.s16)
      ),
      content: BlocConsumer<UserCubit,UserState>(
        builder: (context,state){
          var cubit =UserCubit.get(context);
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      widget.isForgetMail ? LocaleKeys.kForgotEmail.tr() : LocaleKeys.kForgotPassword.tr(),
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
                            showDialog(context: context, builder: (context) => const LogInDialogCustom());
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
                Center(
                  child: Text(LocaleKeys.kPleaseEnterYourPhoneNumber.tr(),
                      style: StyleData.textStyleGray400R16),
                ),
                SizedBox(height: SizeData.s15,),
                InputPhoneCustom(
                  controller: phoneController,
                  labelText: '+${cubit.valCodeCountry} $starsPhoneNumber',
                  onCountryChanged: (val){
                    cubit.changeValCodeCountry(val.dialCode);
                    starsPhoneNumber = '';
                    for(int i = 0; i < val.maxLength; i++) {
                      starsPhoneNumber += '*';
                    }
                  },
                ),

                SizedBox(height: SizeData.s15,),

                (state is FailForgetMailState)?
                ErrorMsgCustom(msg: LocaleKeys.kThisPhoneNumberDoesNotExits.tr(),):Container(),

                SizedBox(height: SizeData.s20,),

                (state is LoadingForgetMailState)?
                const LoadingAppCustom():
                MainButtonCustom(onTap: (){
                  if(phoneController.text.isNotEmpty){
                    if(widget.isForgetMail){
                      cubit.forgetMail(phone: phoneController.text);
                    }else{
                      cubit.resetPasswordLink(phone: phoneController.text);
                    }
                  }else{
                    showErrorToast(context: context,msg:LocaleKeys.kPleaseEnterYourPhoneNumber.tr());
                  }
                }, text: LocaleKeys.kSend.tr(),
                  textStyle: StyleData.textStyle14.copyWith(
                      color: ColorData.whiteColor200,
                      fontSize: Unit(context).getWidthSize*0.042
                  ),
                  color: ColorData.primaryColor1000,),
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
              return buildCheckEmailDialog(context: context,email: state.msg??'');
                });
          }else if(state is ErrorForgetMailState){
            showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
          }

        },
      ),
    );
  }
}