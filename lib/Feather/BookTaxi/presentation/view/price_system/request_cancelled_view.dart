import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/cancel_request_dialog_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/success_dialog.dart';
import 'package:public_app/generated/assets.dart';

class RequestCancelledView extends StatelessWidget {

  final String id;
  RequestCancelledView({super.key, this.id = ''});

  List<String> reasons = [
    LocaleKeys.kPriceIsExpensive.tr(),
    LocaleKeys.kFoundMoreAffordablePrice.tr(),
    LocaleKeys.kClientWillTakeBus.tr(),
    LocaleKeys.kChangeOfPlans.tr(),
    LocaleKeys.kError.tr(),
    LocaleKeys.kOthers.tr()
  ];

  late final BookTaxiCubit cubit;

  bool first = true;

  final ExpansionTileCustomController controller = ExpansionTileCustomController(initiallyExpanded: false);

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
    }
    return BlocListener<BookTaxiCubit, BookTaxiState>(
  listener: (context, state) async {
    if (state is SuccessCancelRequestState) {
      cubit.updateStateLessPageVar(change: (){
        cubit.cancelingRequestSanded = true;
      });
      cubit.reset();
      await buildSuccessDialog(context: context, msg: 'Your cancellation request has been received ');/*showDialog(
          context: context,
          builder: (context) => const CancelRequestDialogCustom());*/
      if (context.mounted) {
        context.go(AppRouter.kLayoutView, extra: true);
      }
    }
  },
  child: BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kRequestCancelled.tr(), iconOneType: IconOneType.back, iconTwoType: IconTwoType.empty,),
          Container(
            margin: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            decoration: BoxDecoration(
              color: ColorData.whiteColor200,
              borderRadius: BorderRadius.circular(SizeData.s16),
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(SizeData.s16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                          decoration: BoxDecoration(
                              color: ColorData.whiteColor200,
                              borderRadius: BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1
                          ),
                          padding: EdgeInsets.all(SizeData.s16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Container(
                                margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeData.s6),
                                  border: Border(
                                      left: BorderSide(
                                          width: Unit(context).width(SizeData.s6),
                                          color: ColorData.warningColor200
                                      )
                                  ),
                                ),
                                padding: EdgeInsets.all(SizeData.s8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.kSorry.tr(),
                                          style: StyleData.textStyleWarning800M16,
                                        ),
                                        Text(
                                          LocaleKeys.kNoCarAvailableNowTryLater.tr(),
                                          style: StyleData.textStyleWarning700R12,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),*/
                              SizedBox(
                                width: Unit(context).iconSize(SizeData.s150),
                                height: Unit(context).iconSize(SizeData.s150),
                                child: LottieBuilder.asset(
                                  Assets.lottieSad,
                                  alignment: Alignment.center,
                                  width: Unit(context).iconSize(SizeData.s150),
                                  height: Unit(context).iconSize(SizeData.s150),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                                child: Text(
                                  LocaleKeys.kAreYouSureYouWantToCancelRequest.tr(),
                                  textAlign: TextAlign.center,
                                  style: StyleData.textStyleGray500M14,
                                ),
                              ),
                              /*Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                child: EasyRichText(
                                  LocaleKeys.kYouCanResumeYourReservationLaterViaMyBookingSection.tr(),
                                  textAlign: TextAlign.center,
                                  defaultStyle: StyleData.textStyleGray500R12,
                                  patternList: [
                                    EasyRichTextPattern(
                                      targetString: LocaleKeys.kMyBooking.tr(),
                                      style: StyleData.textStyleBlue400R12,
                                    ),
                                  ],

                                ),
                              ),*/
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                            child: Text(
                              LocaleKeys.kCancelationReason.tr(),
                              style: StyleData.textStyleGray600R12,
                            ),
                          ),
                        ),
                        ExpansionTileCustom(
                            controller: controller,
                            title: Text(
                              cubit.cancelReason,
                              textAlign: TextAlign.center,
                              style: StyleData.textStyleGray500R14,
                            ),
                            trailing: SvgPicture.asset(
                              Assets.userArrowRightIcon,
                              height: Unit(context).iconSize(SizeData.s22),
                              width: Unit(context).iconSize(SizeData.s22),
                              fit: BoxFit.scaleDown,
                              color: ColorData.grayColor600,
                            ),
                            trailingAngels: TrailingAngels.upAndDown,
                            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                            children: [
                              for (int i = 0; i < reasons.length; i++)...[
                                GestureDetector(
                                  onTap: () {
                                    cubit.updateStateLessPageVar(change: () {
                                      cubit.cancelReason = reasons[i];
                                    });
                                    controller.close();
                                  },
                                  child: Container(
                                    color: reasons[i] == cubit.cancelReason ? ColorData.grayColor50 : null,
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeData.s10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          reasons[i],
                                          style: reasons[i] == cubit.cancelReason ? StyleData.textStyleGray600R14 : StyleData.textStyleGray400R14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                            ]
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: SizeData.s8),
                          child: MainButtonCustom(
                            onTap: () async {
                              if (id.isNotEmpty) {
                                cubit.updateStateLessPageVar(change: (){
                                  cubit.cancelingRequestSanded = false;
                                });

                                cubit.cancelRequest(id: id);

                              } else {
                                cubit.reset();
                                await showDialog(
                                    context: context,
                                    builder: (context) => const CancelRequestDialogCustom());
                                if (context.mounted) {
                                  context.go(AppRouter.kLayoutView, extra: true);
                                }
                              }
                            },
                            text: LocaleKeys.kYesCancel.tr(),
                            textStyle: StyleData.textStyleDanger50M14,
                            color: ColorData.dangerColor1000,
                            loading: !cubit.cancelingRequestSanded,
                            loadingColor: ColorData.dangerColor50,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MainButtonCustom(
                          onTap: () {
                            context.pop();
                          },
                          text: LocaleKeys.kBack.tr(),
                          textStyle: StyleData.textStylePrimary500M14,
                          color: ColorData.primaryColor50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  },
),
);
  }
}
