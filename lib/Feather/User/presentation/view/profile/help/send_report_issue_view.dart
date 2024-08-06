
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
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/dialog_report_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/upload_image_button_custom.dart';


class SendReportIssueView extends StatefulWidget {

  const SendReportIssueView({super.key});

  @override
  State<SendReportIssueView> createState() => _SendReportIssueViewState();
}

class _SendReportIssueViewState extends State<SendReportIssueView> {

  TextEditingController reportController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).deleteImagesSelected();
    super.initState();
  }

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: BlocConsumer<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return Stack(
            children: [
              AppBarCustom(title: LocaleKeys.kReportIssue.tr()),
              Container(
                margin : EdgeInsets.only(top: Unit(context).getHeightSize*0.15,
                    left: SizeData.s15,
                    right: SizeData.s15),
                decoration: BoxDecoration(
                  color: ColorData.whiteColor200,
                  borderRadius: BorderRadius.circular(SizeData.s16),
                ),
                clipBehavior: Clip.antiAlias,
                child: LayoutBuilder(
                    builder: (context,constraint) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraint.maxHeight),
                          child: Form(
                            key: kForm,
                            child: IntrinsicHeight(
                              child: Padding(
                                padding: EdgeInsets.all(SizeData.s16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.kReport.tr(),
                                      style: StyleData.textStyleGray600R14,
                                    ),
                                    SizedBox(height: SizeData.s10,),
                                    InputTextCustom(
                                        controller: reportController,
                                        hintText: LocaleKeys.kTypeHere.tr()),

                                    SizedBox(height: SizeData.s20,),

                                    Text(
                                      LocaleKeys.kImages.tr(),
                                      style: StyleData.textStyleGray600R14,
                                    ),
                                    SizedBox(height: SizeData.s10,),

                                    const ShowImageSelectCustom(),
                                    const UploadImageButtonCustom(),

                                    SizedBox(height: SizeData.s15,),
                                    const Spacer(),

                                    (state is LoadingSendReportState)?
                                    const LoadingAppCustom():MainButtonCustom(
                                      onTap: (){
                                        if(kForm.currentState!.validate()){
                                          cubit.sendReport(report: reportController.text,);
                                        }
                                      },
                                      text: LocaleKeys.kSubmit.tr(),
                                      textStyle: StyleData.textStyle14.copyWith(
                                          color: ColorData.whiteColor200,
                                          fontSize: Unit(context).getWidthSize*0.042
                                      ),
                                      color: ColorData.primaryColor1000,
                                    ),
                                    SizedBox(height: SizeData.s15,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          );
        },
        listener: (context,state){
          if (state is SuccessSendReportState) {
            showDialog(context: context,
                barrierDismissible: false,
                builder: (context){
                  return buildReportDialog(
                      context: context,
                      title: LocaleKeys.kReportSuccessfully.tr(),
                      msg: LocaleKeys.kYourReportIsSubmittedSuccessfully.tr());
                });
          } else if (state is ErrorSendReportState) {
            showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
          }

        },
      ),
    );
  }
}
