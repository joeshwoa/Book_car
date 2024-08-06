import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/change_password_sheet.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/success_dialog.dart';
import 'package:public_app/Feather/User/presentation/view/widget/input_enable_profile_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/user_avatar_custom.dart';
import 'package:public_app/generated/assets.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  bool fullNameEnable = false;
  bool emailEnable = false;
  bool phoneEnable = false;

  String fullNameTemp = '';
  String emailTemp = '';
  String phoneTemp = '';

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  void initState() {
    fullNameController.text = BlocProvider.of<UserCubit>(context).userModel?.dataUserModel?.name??'';
    emailController.text = BlocProvider.of<UserCubit>(context).userModel?.dataUserModel?.email??'';
    phoneController.text = BlocProvider.of<UserCubit>(context).userModel?.dataUserModel?.phone??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: BlocConsumer<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return Stack(
            children: [
              AppBarCustom(title: LocaleKeys.kPersonalData.tr()),
              Padding(
                padding: EdgeInsets.only(top: Unit(context).getHeightSize*0.15,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UserAvatarCustom(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(SizeData.s20),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(SizeData.s15),
                              decoration: ConstantData.decorationUser,
                              child: Form(
                                key: kForm,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.kAccountInfo.tr(),
                                      style: StyleData.textStyle14.copyWith(
                                          fontSize: Unit(context).getWidthSize*0.037,
                                          color: ColorData.grayColor500
                                      ),
                                    ),
                                    SizedBox(height: SizeData.s15,),

                                    InputEnableProfileCustom(
                                      controller: fullNameController,
                                      focusNode: fullNameFocus,
                                      isEnable: fullNameEnable,
                                      image: Assets.userUserNameIcon,
                                      hintText: LocaleKeys.kFullName.tr(),
                                      fct: () {
                                        fullNameTemp = fullNameController.text;
                                        setState(() {
                                          fullNameEnable=!fullNameEnable;
                                        });
                                      },
                                      doneFct: () {
                                        setState(() {
                                          fullNameEnable=!fullNameEnable;
                                        });
                                      },
                                      closeFct: () {
                                        fullNameController.text = fullNameTemp;
                                        setState(() {
                                          fullNameEnable=!fullNameEnable;
                                        });
                                      },
                                    ),

                                    SizedBox(height: SizeData.s10,),

                                    InputEnableProfileCustom(
                                      controller: emailController,
                                      focusNode: emailFocus,
                                      isEnable: emailEnable,
                                      image: Assets.userSms,
                                      hintText: LocaleKeys.kPhoneNumber.tr(),
                                      fct: () {
                                        emailTemp = emailController.text;
                                        setState(() {
                                          emailEnable=!emailEnable;
                                        });
                                      },
                                      doneFct: () {
                                        setState(() {
                                          emailEnable=!emailEnable;
                                        });
                                      },
                                      closeFct: () {
                                        emailController.text = emailTemp;
                                        setState(() {
                                          emailEnable=!emailEnable;
                                        });
                                      },
                                    ),

                                    SizedBox(height: SizeData.s10,),

                                    InputEnableProfileCustom(
                                      controller: phoneController,
                                      focusNode: phoneFocus,
                                      isEnable: phoneEnable,
                                      image: Assets.userPhoneIcon,
                                      hintText: LocaleKeys.kPhoneNumber.tr(),
                                      phoneField: true,
                                      fct: () {
                                        phoneTemp = phoneController.text;
                                        setState(() {
                                          phoneEnable=!phoneEnable;
                                        });
                                      },
                                      doneFct: () {
                                        setState(() {
                                          phoneEnable=!phoneEnable;
                                        });
                                      },
                                      closeFct: () {
                                        phoneController.text = phoneTemp;
                                        setState(() {
                                          phoneEnable=!phoneEnable;
                                        });
                                      },
                                    ),

                                    SizedBox(height: SizeData.s20,),
                                    if(cubit.fileImage != null ||
                                        phoneController.text != cubit.userModel?.dataUserModel?.phone ||
                                        fullNameController.text != cubit.userModel?.dataUserModel?.name ||
                                        emailController.text != cubit.userModel?.dataUserModel?.email) (state is LoadingEditProfileState)?
                                    const LoadingAppCustom():
                                    MainButtonCustom(
                                      onTap: (){
                                        cubit.editProfile(
                                          phone: phoneController.text,
                                          name: fullNameController.text,
                                          email: emailController.text,
                                        );
                                      },
                                      text: LocaleKeys.kSaveChange.tr(),
                                      textStyle: StyleData.textStyle14.copyWith(
                                          color: ColorData.whiteColor200,
                                          fontSize: Unit(context).getWidthSize*0.042
                                      ),
                                      color: ColorData.primaryColor1000,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: SizeData.s20,),

                            cardArrow(fct: (){
                              buildChangePasswordSheet(context: context);
                            },
                              context: context,
                              title: LocaleKeys.kChangePassword.tr(),),

                            SizedBox(height: SizeData.s20,),

                            cardArrow(fct: (){
                              GoRouter.of(context).push(AppRouter.kSavedPlacesView);
                            },
                              context: context,
                              title: LocaleKeys.kSavedPlaces.tr(),),

                            SizedBox(height: SizeData.s20,),
                            (state is LoadingDeleteAccountState)?const LoadingAppCustom():GestureDetector(
                              onTap: () {
                                cubit.deleteAccount();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.kDeleteMyAccount.tr(),
                                    style: StyleData.textStyle14Regular.copyWith(
                                        color: ColorData.dangerColor500,
                                        fontSize: Unit(context).getWidthSize*0.037
                                    ),
                                  ),
                                  SizedBox(width: SizeData.s5,),
                                  SvgPicture.asset(
                                    Assets.userTrashIcon,
                                    width: Unit(context).getWidthSize*0.064,
                                    height: Unit(context).getWidthSize*0.064,
                                    color: ColorData.dangerColor500,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeData.s20,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        listener: (context,state){
          if(state is SuccessDeleteAccountState){
            BlocProvider.of<UserCubit>(context).changeCurrentIndexLayout(0);
            context.go(AppRouter.kLayoutView);
            BlocProvider.of<UserCubit>(context).logout();
          }else if(state is ErrorDeleteAccountState || state is ErrorEditProfileState){
            showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
          }else if(state is SuccessEditProfileState){
            showDialog(context: context,
                barrierDismissible: false,
                builder: (context){
                  return buildSuccessDialog(context: context,msg: LocaleKeys.kYourDataHasBeenSavedSuccessfully.tr());
            });
          }
        },
      ),
    );
  }

  Widget cardArrow({required Function() fct ,required BuildContext context,required String title}){
    return GestureDetector(
      onTap: fct,
      child: Container(
       padding: EdgeInsets.all(SizeData.s10),
        decoration: ConstantData.decorationUser,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                style: StyleData.textStyle14.copyWith(
                  color: ColorData.grayColor500,
                  fontSize: Unit(context).getWidthSize*0.037
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.userArrowRightIcon,
              width: Unit(context).getWidthSize*0.064,
              height: Unit(context).getWidthSize*0.064,
              color: ColorData.grayColor500,
            ),
          ],
        ),
      ),
    );
  }

}
